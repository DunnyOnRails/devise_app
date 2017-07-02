class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def profile_comments
  end

  def profile_history
  end

  def profile_projects
  end

  def profile_settings
  end

  def profile_summary
    #Populate the @profile instance variable using username
    @profile = Profile.find_by_username(current_user.username)
  end

  def profile_details
    #Populate the @profile instance variable using username
    @profile = Profile.find_by_username(current_user.username)
  end

  def show
    # ensure the logged in user can only access their own profile url (profiles/:id)
    @profile = Profile.find_by_username(current_user.username)
    if @profile.id.to_s != params[:id] then
      redirect_back(fallback_location:profiles_profile_summary_path, notice: "This action is not alowed; you can only view the details that belong to you.")
    end
  end

  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
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
      @profile = Profile.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name,:username,:company_name, :main_email, :main_phone, :office_phone, :one_line_address)
    end
end
