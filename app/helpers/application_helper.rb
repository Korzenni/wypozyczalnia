module ApplicationHelper
  def parse_role(role)
    case role
    when 0
      'User'
    when 1
      'Admin'
    when 2
      'Owner'
    end
  end
end
