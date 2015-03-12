class AddBusinessHoursTable < ActiveRecord::Migration
  def self.up
    create_table :business_hours do |t|
      t.integer   :company_id, :null => false
      t.integer   :day, :null => false
      t.time      :open, :null => false
      t.time      :close, :null => false
    end
  end

  def self.down
    drop_table :business_hours
  end
end
