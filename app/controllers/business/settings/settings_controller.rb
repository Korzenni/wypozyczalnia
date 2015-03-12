module Business
  module Settings
    class SettingsController < ApplicationController
      before_action :authenticate_user!
      before_action :redirect_if_not_business_partner

      def hours
        @company = current_user.company
        if @company.business_hours.count == 0
          7.times do |day|
            @company.business_hours.build(company: @company, day: day)
          end
        end
      end

      def save_hours
        @company = current_user.company
        binding.pry
      end

      private

      def hours_params
        params.require(:company).permit(business_hours_attributes: [:id, :open, :close, :day])
      end
    end
  end
end
