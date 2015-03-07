class ItemCategoryQuery
  def initialize(params, current_user)
    @params = params
    @search = params[:q].present?
    @user = current_user
  end

  def call
    @item_categories = @user.company.item_categories
    if @search
      @item_categories.search_by_name(@params[:q])
    else
      @item_categories
    end
  end
end
