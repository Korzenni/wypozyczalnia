module Business
  class ItemCategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_if_not_business_partner

    def index
      @item_categories = ItemCategoryQuery.new(params, current_user).call
      respond_to do |format|
        format.json { render json: { item_categories: @item_categories } }
        format.html {}
      end
    end

    def show
      @item_category = current_user.company.item_categories.find(params[:id])
    end

    def new
      @item_category = ItemCategory.new
    end

    def create
      @item_category = ItemCategory.new(item_category_params)
      @item_category.company = current_user.company
      if @item_category.save
        redirect_to business_item_categories_path, notice: 'You created item category with success.'
      else
        render :new
      end
    end

    private

    def item_category_params
      params.require(:item_category).permit(:name, :price, :deposit, :description)
    end
  end
end
