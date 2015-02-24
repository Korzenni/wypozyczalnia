module Business
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner

    def index
      @company = current_user.company
      @users = current_user.company.users
    end

  end
end
