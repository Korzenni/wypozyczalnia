class ItemCategory < ActiveRecord::Base
  belongs_to :company
  has_many :items

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :deposit, numericality: { greater_than: 0 }, allow_blank: true
  validates :company, presence: true
end
