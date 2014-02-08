class AddStatusToSchedule < ActiveRecord::Migration
  def self.up
	add_column :schedules, :status, :integer, :default=>0

  end

  def self.down
	remove_column :schedules, :status 
  end
end
