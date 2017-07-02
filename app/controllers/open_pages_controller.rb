class OpenPagesController < ApplicationController
  def sign_up
  end
  def main
  end
  # These helper methods are required so we can use bespoke signin / signup forms rather than Devise views
# One of these would be needed in each controller if supporting signup forms /functionality in different subdirectories of the site.
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
end
