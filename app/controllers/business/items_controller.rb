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

    def create
      @item = Item.new(item_params)
      @item.company = current_user.company
      if @item.save
        redirect_to business_items_path, notice: 'You created item with success.'
      else
        render :new
      end
    end

    private

    def item_params
      params.require(:item).permit(:name, :price, :deposit, :description, :inventory_number)
    end
  end
end
