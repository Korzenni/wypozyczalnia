class ItemCreator
  attr_reader :item
  attr_reader :saved
  alias_method :saved?, :saved

  def initialize(params, current_user)
    @user = current_user
    @params = params
  end

  def create
    @item = Item.new(item_params)
    @item.company = @user.company
    @saved = @item.save
  end

  def find_or_create_category
    @item_category = @params[:item][:item_category]
    binding.pry
    return unless @item_category.length > 0
    if @item_category.to_i > 0
      @item.update_attributes(item_category_id: @item_category)
    else
      @item_category = ItemCategory.create(
        name: @item_category,
        price: @item.price,
        deposit: @item.deposit,
        description: @item.description,
        company: @user.company
      )
      @item.update_attributes(item_category_id: @item_category.id)
    end
  end

  private

  def item_params
    @params.require(:item).permit(:name, :price, :deposit, :description, :inventory_number)
  end
end
