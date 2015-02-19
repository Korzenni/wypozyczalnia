class Users::RegistrationsController < Devise::RegistrationsController
  def new_company
    @user = User.new
  end

  def create_company
    # @user = User.new(create_company_params)
    # user_creator = UserCompanyCreator.new(create_company_params)
    # user_creater.save_user
    # user_creator.create_company
    # redirect w przypadku sukcesu root
    # render new_company
  end

  protected

  def create_company_params
    params.require(:user).permit(:email, :password, :password_confirmation, :company_name)
  end
end
