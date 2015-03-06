class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.string :name
      t.decimal :price
      t.decimal :deposit
      t.text :description

      t.timestamps
    end
  end
end
