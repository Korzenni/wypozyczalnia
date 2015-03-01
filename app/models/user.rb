class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable, :invitable

  has_many :memberships, dependent: :destroy
  has_many :companies, through: :memberships

  accepts_nested_attributes_for :companies

  def business_partner?
    companies.count > 0
  end

  def company
    companies.first
  end

  def role
    memberships.first.try(:role)
  end

  def is_owner?
    memberships.first.try(:role) == 2
  end

  def has_permissions?
    memberships.first.try(:role) == 2 || memberships.first.try(:role) == 1
  end

  def toggle_role!
    case role
    when 0
      memberships.first.update_attributes(role: 1)
    when 1
      memberships.first.update_attributes(role: 0)
    else
      raise "User's role cannot be toggled! (is owner)"
    end
  end

  def possible_roles
    case role
    when 0
      [1]
    when 1
      [0]
    else
      []
    end
  end
end
