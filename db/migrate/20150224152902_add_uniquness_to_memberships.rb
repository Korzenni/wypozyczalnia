class AddUniqunessToMemberships < ActiveRecord::Migration
  def change
    add_index(:memberships, [:user_id, :company_id], :unique => true)
  end
end
