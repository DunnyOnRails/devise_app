class RegistrationsController < Devise::RegistrationsController

  # DD - This overrides the standard Devise sign up method and allows
  # me to allow new parameters to be passed to the user miodel for saving
  # Notice the name of the method - this is the default devise name and shouldnt be changed
  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :agreed_terms, :agreed_subscribe)
  end

# DD this code block is overriding the standard Devise 'create' method. If sign in fails it calls the
# response_to_sign_up_failure below
 def create
   build_resource(sign_up_params)
   resource.save
# Next 3 lines write the new username into the profiles table
   @profile = Profile.new
   @profile.username = resource.username
   @profile.save

   yield resource if block_given?
  if resource.persisted?
    if resource.active_for_authentication?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  else
    clean_up_passwords resource
    set_minimum_password_length
    resource.errors.full_messages.each {|x| flash[x] = x} # Rails 4 simple way
    response_to_sign_up_failure resource
  end
  end

private
def response_to_sign_up_failure(resource)
#DD - capture the email and username parameters from the signup form so that when the
# redirect happens (which does a GET) we dont lose the entered parameters. They get
# populated again in the sign_up form. Using flash messages so I am not persisting the
# data unneccessarily
  flash[:email] = resource.email
  flash[:username] = resource.username

  #params.each do |key,value|
  #  Rails.logger.warn "Param #{key}: #{value}"
  #end

      ##Obsolete debug code - remove once documented.
      ##@resource_email = resource.email
      ##@resource_password = params[:password]
      ##@resource_password_confirmation = resource.password_confirmation

      ##Rails.logger.debug("My EMAIL object: #{@resource_email.inspect}")
      ##Rails.logger.debug("My PASSWORD object: #{@resource_password.inspect}")
      ##Rails.logger.debug("My CONFIRM_PASSWORD object: #{@resource_password_confirmation.inspect}")
    ##if resource.email == "" && resource.password == nil
  if resource.username == ""
    #render :sign_up // This doesnt work as it injects the standard Devise user sign up page
    #into my sign_up page, therefore I redirect and the parameters from above are captured
    #and put back into the sign_up form
    redirect_to  open_pages_sign_up_path,render, alert: "Please add your username"
  elsif resource.email == ""
      redirect_to  open_pages_sign_up_path, alert: "Please add your email address"
    #checking for duplicate email address and username (already in the database?)
  elsif User.pluck(:username).include? resource.username
      redirect_to  open_pages_sign_up_path, alert: "Username already exists"
  elsif User.pluck(:email).include? resource.email
      redirect_to  open_pages_sign_up_path, alert: "Email already exists"
  end
end
 end
