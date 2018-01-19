class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, 
  :destroy, :profile_summary, :profile_details, :profile_comments]
  before_action :set_notification, only: [:show, :create_update_notifications]
  before_action :authenticate_user!

  def update_password
# DD -  update the changed user details, in this instance the password
    @user = User.find(current_user.id)

    if @user.update(user_params)
# DD - Sign in the  bypassing validation as Devise tries to login again 
# DD - if password changed and this causes an error ;then redirect to profiles/:id
      bypass_sign_in(@user)
      redirect_to "/profiles/#{current_user.id}", notice: 'Password was successfully updated.'
    else
# DD - if the record cant be saved for some reason then reload page with an error message
      redirect_to "/profiles/#{current_user.id}", alert: 'An error has occurred - please check all details entered and try again'
    end
  end

  def profile_comments
  end

  def profile_history
  end

  def profile_projects
  end

  def profile_settings
  end

  def profile_summary
  end

  def profile_details
  end

  def show
  end

def edit
  @user = current_user
end

  def create_update_notifications
# DD - This method is called from show.html and creates a new notifications record
# DD - if one doesnt already exist; if one does exist it updates it
# DD - in both cases it sete the redirect correctly to pofiles/:id

  @notification.update(notification_params)
  redirect_to "/profiles/#{current_user.id}", notice: 'Notifications were successfully updated.'

  end

# DD - Update an existing profile - it will always be there as it is created when the user is created (but is empty)
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
      else
             format.html { redirect_to @profile, alert: @profile.errors.full_messages }
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
      if @profile.nil? then
        @profile = Profile.find_by_user_id(current_user.id)
     end
    end
    def set_notification
      if @notification.nil? then
        @notification = Notification.find_by_user_id(current_user.id)
     end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
    # if a handle wasnt entered then downcase the name amd remove the spaces otherwise do same to handle
      if params[:profile][:handle].blank?  
        params[:profile][:handle] = params[:profile][:name].downcase.gsub(/[^0-9a-z]/i, "")
      else
        params[:profile][:handle] = params[:profile][:handle].downcase.gsub(/[^0-9a-z]/i, "")
      end
      params.require(:profile).permit(:name,:username,:company_name, :main_email, :main_phone, :office_phone, :one_line_address, :avatar,:handle)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:user_id, :allow_emailmsg,:allow_smsmsg,:allow_socialmsg, :allow_webmsg, :allow_post)
    end

    # DD - these helper methods are required so we can use bespoke signin / signup forms rather than Devise views
    # I think these helper methods will be needed in each controller involved in a signup and redirect
    # private

    # def resource_name
    #   :user
    # end
    # helper_method :resource_name

    # def resource
    #   @resource ||= User.new
    # end
    # helper_method :resource

    # def devise_mapping
    #   @devise_mapping ||= Devise.mappings[:user]
    # end
    # helper_method :devise_mapping

    # def resource_class
    #   User
    # end
    # helper_method :resource_class


  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :agreed_terms, :agreed_subscribe)
  end
end
