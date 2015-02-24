module Business
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner

    def show

    end
  end
end
