class Item < ActiveRecord::Base
  belongs_to :item_category
  belongs_to :company

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :deposit, numericality: { greater_than: 0 }, allow_blank: true
  validates :inventory_number, presence: true
  validates :company, presence: true
end
