class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_signed_in!

  def new_company
    @user = User.new
    @user.companies.build
  end

  def create_company
    @user = User.new(create_company_params)
    if @user.save
      @user.memberships.first.update_attributes(role: 2)
      sign_in @user
      redirect_to root_path, notice: "You created company with success."
    else
      render :new_company
    end
  end

  protected

  def create_company_params
    params.require(:user).permit(:email, :password, :password_confirmation, companies_attributes: :name)
  end

  def redirect_if_signed_in!
    redirect_to root_path, notice: "You have already signed up!" if current_user
  end
end
