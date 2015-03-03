class ItemCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_business_partner

  def index
    @item_categories = current_user.company.item_categories
  end

  def show
    @item_category = current_user.company.item_categories.find(params[:id])
  end

  def new
    @item_category = ItemCategory.new
  end
end
