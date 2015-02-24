class AddDefaultToMemberships < ActiveRecord::Migration
  def change
    change_column_default :memberships, :role, '0'
  end
end
