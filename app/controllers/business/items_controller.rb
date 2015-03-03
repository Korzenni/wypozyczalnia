module Business
  class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner

    def index
      @items = current_user.company.items
    end

    def show
      @item = current_user.company.items.find(params[:id])
    end

    def new
      @item = Item.new
    end
  end
end
