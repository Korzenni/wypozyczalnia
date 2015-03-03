class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.decimal :deposit
      t.text :description
      t.string :inventory_number

      t.timestamps
    end
  end
end
