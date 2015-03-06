class Company < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships

  has_many :items
  has_many :item_categories

  validates :name, presence: true
end
