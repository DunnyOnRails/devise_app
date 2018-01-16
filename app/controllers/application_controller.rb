class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def index
  end

# DD - added this so I can control which page a user goes to after signing in.
  def after_sign_in_path_for(resource)
    pages_main_path 
  end
end
