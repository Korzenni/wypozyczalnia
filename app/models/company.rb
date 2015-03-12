class Company < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships

  has_many :items
  has_many :item_categories
  has_many :business_hours

  validates :name, presence: true

  accepts_nested_attributes_for :business_hours
end
