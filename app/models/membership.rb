class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validate :user_id
  validate :company_id
  validate :role
end
