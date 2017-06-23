  class CustomFailure < Devise::FailureApp
  #DD - This is a method for redirecting a failed Devise login to my chosen path rather than the default.
    def redirect_url
      open_pages_sign_up_path
    end

    def respond
      if http_auth?
        http_auth
      else
        redirect
      end
    end
  end
