class Item < ActiveRecord::Base
  belongs_to :item_category
  belongs_to :company

  validates :company, presence: true
end
