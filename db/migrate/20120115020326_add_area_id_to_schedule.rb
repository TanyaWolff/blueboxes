class AddAreaIdToSchedule < ActiveRecord::Migration
  def self.up
 	add_column :schedules, :area_id, :integer
  end

  def self.down
	remove_column :schedules, :area_id
  end
end
