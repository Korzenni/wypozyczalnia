class Users::RegistrationsController < Devise::RegistrationsController
  def new_company
    @user = User.new
end
