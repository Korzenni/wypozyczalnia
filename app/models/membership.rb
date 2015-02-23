class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :user_id, presence: true
  validate :company_id, presence: true
  validate :role, presence: true
end
