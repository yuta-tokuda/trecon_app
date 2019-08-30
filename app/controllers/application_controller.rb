class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_user_notification

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

  def paging(models, per = 10)
    Kaminari.paginate_array(models).page(params[:page]).per(per)
  end

  def current_user_notification
    @notifications = current_user.passive_notifications if user_signed_in?
  end
end
