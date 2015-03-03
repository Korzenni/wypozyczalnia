class AddCompanyToItemCategories < ActiveRecord::Migration
  def change
    add_column :item_categories, :company_id, :integer
  end
end
