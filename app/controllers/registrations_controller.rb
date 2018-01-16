class RegistrationsController < Devise::RegistrationsController

# DD - This overrides the standard Devise sign up method and allows
# DD - me to allow new parameters to be passed to the user model for saving
# DD - Notice the name of the method - this is the default devise name and shouldnt be changed
  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :agreed_terms, :agreed_subscribe)
  end

# DD this code block is overriding the standard Devise 'create' method. If sign in fails it calls the
# response_to_sign_up_failure below
 def create
# DD - create the devise user passing in the parameters required and pass the results into 'resource' -this
# DD - is now the 'user model' and contains the user attributes e.g. resource.id etc
   build_resource(sign_up_params)
   resource.save
# Next 3 lines write the new username into the profiles table
   #@profile = Profile.new
   #@profile.username = resource.username
   #@profile.save

# DD - As far as I understand this code block basically says - if the 'resource' object isnt empty (which it never shpould be)
# DD - then run the remaining code. This code firstly checks that the user record hasn't been destroyed
# DD - then checks that the user model is still active and allowing authentication. If all is well it will set the value of
# DD - the flash message, sign the user up and redirect to the appropriate path after sign up.
# DD - if for some reason the sign up cant happen it will set notice value to say the user is inactive (although the user record
# DD - may well still exist and then it will clear the data and redirect accordingly
# DD - Otherwise it will clear any password data, set the password length and call the response_to_sign_up_failure method
# DD - passing in the user object (resource)
   yield resource if block_given?
  if resource.persisted?
    if resource.active_for_authentication?
# TODO = wrap the creation of the user and the creation of the profile into one?
      puts "got in here 1"
      puts "This is the id #{resource.id}"

          @profile = Profile.new
          @profile.user_id = resource.id
          @profile.save
          puts "got in here with errors#{@profile.errors.full_messages}"
      
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
# DD - setting the session ID in case I need it elsewhere but I think Devise maintains this in current_user.id anyway
      session["user_id"] = resource.id
# DD - Create an empty profile keyed off user_id - need this to allow profile details to be added later

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
# DD - Firstly I capture the email and username parameters from the signup form so that when the
# DD - redirect happens (which does a GET) we dont lose the entered parameters. They get
# DD - populated again in the sign_up form. Using flash messages so I am not persisting the
# DD - data unneccessarily
  flash[:email] = resource.email
  flash[:username] = resource.username

# DD -------------------DEBUG CODE --------------------------------------
  # params.each do |key,value|
  #  Rails.logger.warn "Param #{key}: #{value}"
  # end
      ##Obsolete debug code - remove once documented.
      ##@resource_email = resource.email
      ##@resource_password = params[:password]
      ##@resource_password_confirmation = resource.password_confirmation

      ##Rails.logger.debug("My EMAIL object: #{@resource_email.inspect}")
      #Rails.logger.debug("My PASSWORD object: #{@resource_password.inspect}")
      ##Rails.logger.debug("My CONFIRM_PASSWORD object: #{@resource_password_confirmation.inspect}")
    ##if resource.email == "" && resource.password == nil
# DD --------------------END DEBUG CODE--------------------------------------

# DD - Checking username / email arent blank (also checked client side) and also they dont already exist in the DB
  if resource.username == ""
    #render :sign_up // This doesnt work as it injects the standard Devise user sign up page
    #into my sign_up page, therefore I redirect and the parameters from above are captured
    #and put back into the sign_up form
    redirect_to  open_pages_sign_up_path, alert: "Please add your username"
  
  elsif User.pluck(:username).include? resource.username
    redirect_to  open_pages_sign_up_path, alert: "Username already exists"
  elsif resource.email == ""
        redirect_to  open_pages_sign_up_path, alert: "Please add your email address"
    #checking for duplicate email address and username (already in the database?)
  elsif User.pluck(:email).include? resource.email
        redirect_to  open_pages_sign_up_path, alert: "Email already exists"
  elsif params[:user][:password].blank?
        redirect_to  open_pages_sign_up_path, alert: "Password cannot be empty"
  elsif params[:user][:password_confirmation] != params[:user][:password]
        redirect_to  open_pages_sign_up_path, alert: "Passwords must match"
  elsif params[:user][:agreed_terms].to_s != 'true'
            redirect_to  open_pages_sign_up_path, alert: "Please accept our terms!!"
  end
end
 end
