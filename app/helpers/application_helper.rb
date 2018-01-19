module ApplicationHelper
  def setBreadcrumb(siteSegment, sitePage, segmentName, pageName)
    session[:siteSegment] = siteSegment
    session[:sitePage] = sitePage
    session[:segmentName] = segmentName
    session[:pageName] = pageName
    page_address = request.original_url
  end

  # helper_method :resource_name, :resource, :devise_mapping, :resource_class

   # DD - these helper methods are required so we can use bespoke signin / signup forms rather than Devise views
   # I think these helper methods will be needed in each controller involved in a signup and redirect
    def resource_name
    :user
  end

  # def resource_name2
  #   :user
  # end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
