module Business
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner
    before_action -> { verify_user_permissions!(business_users_path) }, except: :index

    def index
      @company = current_user.company
      @users = current_user.company.users
    end

  end
end
