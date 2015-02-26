class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def redirect_if_not_business_partner
    redirect_to root_path, notice: 'You are not business partner.' unless current_user.business_partner?
  end
end
