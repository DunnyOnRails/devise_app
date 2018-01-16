class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def update_password
# DD -  update the changed user details, in this instance the password
    @user = User.find(current_user.id)

    if @user.update(user_params)
# DD - Sign in the user by passing validation as Devise tries to login again if password changed and this causes an error
# DD - then redirect to profiles/:id
      bypass_sign_in(@user)
      @myvar = ('/profiles/' + current_user.id.to_s)
      redirect_to @myvar, notice: 'Password was successfully updated.'
    else
# DD - if the record cant be saved for some reason then reload page with an error message
# DD - not ideal as user input is lost but not sure how else to do this at the moment.
      @profile = Profile.find_by_user_id(current_user.id)
      @myvar = ('/profiles/' + current_user.id.to_s)
      redirect_to @myvar, :alert => "An error has occurred - please check all details entered and try again"
      end
  end

  def profile_comments
    @profile = Profile.find_by_user_id(current_user.id)
  end

  def profile_history
  end

  def profile_projects
  end

  def profile_settings
  end

  def profile_summary

  # DD - If there is isnt  a current profile record create an empty instance of the object
    if @profile.nil?
    @profile = Profile.new
    else
# DD - Otherwise load object with notifications record for current user
    @profile = Profile.find_by_user_id(current_user.id)
    end
  end

  def profile_details
# DD - Populate the @profile instance variable using username
    @profile = Profile.find_by_user_id(current_user.id)
  end

  def show
# DD - ensure the logged in user can only access their own profile url (profiles/:id)
    @profile = Profile.find_by_user_id(current_user.id)
    # if @profile.id.to_s != params[:id]  then
    #   redirect_back(fallback_location:profiles_profile_summary_path, notice: "This action is not allowed; you can only view the details that belong to you.")
    # end
# DD - Instantiate @notification instance variable  by trying to load record for current user
    @notification = Notification.find_by_user_id(current_user.id)
# DD - If there is isnt  a current notifications record create an empty instance of the object
    if @notification.nil?
      @notification = Notification.new
    else
# DD - Otherwise load object with notifications record for current user
    @notification = Notification.find_by_user_id(current_user.id)
  end
  end

def edit
  @user = current_user
end

  def create_update_notifications
# DD - This method is called from show.html and creates a new notifications record
# DD - if one doesnt already exist; if one does exist it updates it
# DD - in both cases it sete the redirect correctly to pofiles/:id

          @notification = Notification.find_by_user_id(current_user.id)

          if @notification.nil?
            @notification = Notification.new
            @notification.update(notification_params)
            @myvar = ('/profiles/' + current_user.id.to_s)
            redirect_to @myvar, notice: 'Notifications were successfully created.'
          else
            @notification = Notification.find_by_user_id(current_user.id)
            @notification.update(notification_params)
            @myvar = ('/profiles/' + current_user.id.to_s)
            redirect_to @myvar, notice: 'Notifications were successfully updated.'

            end
  end

# DD - Update an existing profile - it will always be there as it is created when the user is created (but is empty)
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        # format.json { render :show, status: :ok, location: @profile }
      else
             format.html { redirect_to @profile, alert: @profile.errors.full_messages }
        # format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

# DD - not currently used as I dont allow profiles to be deleted
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      # @profile = Profile.find(params[:id])
      # @profile = Profile.find(current_user.id)
      @profile = Profile.find_by_user_id(current_user.id)
      #@profile.id.to_s != params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
    # if a handle wasnt entered then downcase the name amd remove the spaces otherwise do same to handle
      if params[:profile][:handle].blank?  
        params[:profile][:handle] = params[:profile][:name].downcase.gsub(/\s+/, "")
      else
        params[:profile][:handle] = params[:profile][:handle].downcase.gsub(/\s+/, "")
      end
      params.require(:profile).permit(:name,:username,:company_name, :main_email, :main_phone, :office_phone, :one_line_address, :avatar,:handle)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:user_id, :allow_emailmsg,:allow_smsmsg,:allow_socialmsg, :allow_webmsg, :allow_post)
    end

    # DD - these helper methods are required so we can use bespoke signin / signup forms rather than Devise views
    # I think these helper methods will be needed in each controller involved in a signup and redirect
    private

    def resource_name
      :user
    end
    helper_method :resource_name

    def resource
      @resource ||= User.new
    end
    helper_method :resource

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
    helper_method :devise_mapping

    def resource_class
      User
    end
    helper_method :resource_class


  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :agreed_terms, :agreed_subscribe)
  end
end
