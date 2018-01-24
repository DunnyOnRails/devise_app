class PagesController < ApplicationController
before_action :authenticate_user!

# DD - methods required in order to set up routing so pages can be displayed.
  def index
  end
  def main
    @notice = Notice.where("visible = true").order("created_at")
    @event = Event.where("visible = true").order("date")
    @user = current_user
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



end
