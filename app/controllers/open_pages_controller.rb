class OpenPagesController < ApplicationController
  def sign_up
  end
  def main
  end

# DD - These helper methods are required so we can use bespoke signin / signup forms rather than Devise views
# DD - One of these is needed in each controller if supporting signup forms /functionality in different subdirectories of the site.
  private

  def resource_name
    :user
  end
  helper_method :resource_name

  def resource
# DD = Interesting notation here (||=). This expression  will give @resource a value if it does not yet have a value
# DD otherwise it'll do nothing.
    @resource ||= User.new
  end
  helper_method :resource

# DD - Not convinced these 2 methods are used at all?
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping

  def resource_class
    User
  end
  helper_method :resource_class
end
