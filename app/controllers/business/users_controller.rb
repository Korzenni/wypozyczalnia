module Business
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner
    before_action -> { verify_user_permissions!(business_users_path) }, except: :index

    def index
      @company = current_user.company
      @users = ::UserDecorator.decorate_collection(current_user.company.users)
    end

    def toggle_role
      @company = current_user.company
      user = User.find(params[:id]).decorate
      if !user.is_owner? && @company.users.include?(user) && user != current_user
        user.toggle_role!
        flash[:notice] = "You changed user's role to #{user.current_role}."
      else
        flash[:alert] = "You cannot change role of that user."
      end
      redirect_to business_users_path
    end

    def destroy
      @company = current_user.company
      user = User.find(params[:id])
      if !user.is_owner? && @company.users.include?(user) && user != current_user
        user.destroy
        flash[:notice] = "You deleted user with success."
      else
        flash[:alert] = "You cannot delete that user."
      end
      redirect_to business_users_path
    end
  end
end
