class ItemCategory < ActiveRecord::Base
  belongs_to :company
  has_many :items

  validates :company, presence: true
end
