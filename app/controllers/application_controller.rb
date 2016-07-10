class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :remember_me])
  end
end
