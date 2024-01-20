class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation bio])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password password_confirmation bio])

    # Set default role to "user" if not provided during registration
    return unless params[:action] == 'create' && params[:controller] == 'devise/registrations'

    params[:user][:role] ||= 'user'
  end
end
