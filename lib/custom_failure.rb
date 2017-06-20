class CustomFailure < Devise::FailureApp
## This is a method for redirecting a failed Devise login to my chosen path ratrher than the default.
  def redirect_url
    open_pages_index_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
