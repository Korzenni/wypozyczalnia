class AddItemCategoryToItem < ActiveRecord::Migration
  def change
    add_column :items, :item_category_id, :integer
  end
end
