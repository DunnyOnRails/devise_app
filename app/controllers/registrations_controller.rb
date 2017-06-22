class RegistrationsController < Devise::RegistrationsController


 def create
   build_resource(sign_up_params)

   resource.save
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
    if resource.email == "" 
    redirect_to open_pages_sign_up_path, alert: "Please fill in the form"
  elsif User.pluck(:email).include? resource.email
    Rails.logger.debug("I made it into the elseif clause")
    redirect_to  open_pages_sign_up_path, alert: "Email already exists"
  end
end
 end
