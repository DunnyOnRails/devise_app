module ApplicationHelper
  def setBreadcrumb(siteSegment, sitePage, segmentName, pageName)
    session[:siteSegment] = siteSegment
    session[:sitePage] = sitePage
    session[:segmentName] = segmentName
    session[:pageName] = pageName
    page_address = request.original_url
  end

  # helper_method :resource_name, :resource, :devise_mapping, :resource_class
# Put this in to try and get client side validations working so might be able to remove later
  def resource_name
    :user
  end

  def resource_name2
    :user
  end
 
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
