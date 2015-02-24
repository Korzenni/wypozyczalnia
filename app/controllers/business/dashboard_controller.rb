module Business
  class DashboardController < ActionController::Base
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner

    def show

    end

    private

    def redirect_if_not_business_partner
      redirect_to root_path, notice: 'You are not business partner.' unless current_user.business_partner?
    end
  end
end
