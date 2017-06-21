class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def index
  end

  def after_sign_in_path_for(resource)
    pages_main_path
end
## protected
## def authenticate_user!
  ##if user_signed_in?
    ##super
  ##else
  ##  redirect_to new_user_session_path, :notice => 'You are seeing this notice because you are not signed in'
    ##redirect_to open_pages_sign_up_path, :notice => 'Please sign in or sign up'


    ## if you want render 404 page
    ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
  #end
#end
end
