class AddScheduleIdToShift < ActiveRecord::Migration
  def self.up
    add_column :shifts, :schedule_id, :integer
  end

  def self.down
    remove_column :shifts, :schedule_id
  end
end
