class Company < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships

  validates :name, presence: true
end
