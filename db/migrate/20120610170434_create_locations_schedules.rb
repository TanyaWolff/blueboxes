class CreateLocationsSchedules < ActiveRecord::Migration
   def self.up
   create_table :locations_schedules, :id => false do |t|
      t.integer :schedule_id
      t.integer :location_id
    end

  end
def self.down
	drop_table :locations_schedules
end
end
