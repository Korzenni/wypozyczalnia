class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable

  has_many :memberships
  has_many :companies, through: :memberships

  accepts_nested_attributes_for :companies

  def business_partner?
    companies.count > 0
  end

  def company
    companies.first
  end
end
