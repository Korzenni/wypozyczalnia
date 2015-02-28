module Business
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner
    before_action -> { verify_user_permissions!(business_users_path) }, except: :index

    def index
      @company = current_user.company
      @users = current_user.company.users
    end

    def destroy
      @company = current_user.company
      user = User.find(params[:id])
      if !user.is_owner? && @company.users.include?(user)
        user.destroy
        flash[:notice] = "You deleted user with success."
      else
        flash[:alert] = "You cannot delete that user."
      end
      redirect_to business_users_path
    end
  end
end
