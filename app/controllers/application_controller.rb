class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def redirect_if_not_business_partner
    redirect_to root_path, notice: 'You are not business partner.' unless current_user.business_partner?
  end

  def verify_user_permissions!(return_path = nil)
    redirect_to return_path || business_dashboard_path, notice: 'You do not have enough permissions.' unless current_user.has_permissions?
  end
end
