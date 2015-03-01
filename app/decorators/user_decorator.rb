class UserDecorator < Draper::Decorator
  delegate_all

  def current_role
    case object.role
    when 0
      'User'
    when 1
      'Admin'
    when 2
      'Owner'
    end
  end
end
