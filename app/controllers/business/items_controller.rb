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
      @item_creator = ItemCreator.new(params, current_user)
      @item_creator.create
      if @item_creator.saved?
        @item_creator.find_or_create_category
        redirect_to business_items_path, notice: 'You created item with success.'
      else
        @item = @item_creator.item
        render :new
      end
    end

    private


  end
end
