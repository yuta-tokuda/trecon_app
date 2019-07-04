class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_not_authorized
    return if user_signed_in?

    flash[:error] = 'ログインしてください。'
    redirect_to(request.referer || root_path)
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[name_first name_last email password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
