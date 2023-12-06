class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo, :username, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo, :username, :first_name, :last_name])
  end
end
