module Business
  module Settings
    class SettingsController < ApplicationController
      before_action :authenticate_user!
      before_action :redirect_if_not_business_partner

      def hours
        binding.pry #debugowanie
      end
    end
  end
end
