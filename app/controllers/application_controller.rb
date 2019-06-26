class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_not_authorized
    return if user_signed_in?

    flash[:error] = 'ログインしてください。'
    redirect_to(request.referer || root_path)
  end
end
