class CreateShifts < ActiveRecord::Migration
  def self.up
    create_table :shifts do |t|
      t.datetime :start
      t.integer  :location_id, :options =>
        "CONSTRAINT fk_shift_locations REFERENCES locations(id)"
      t.integer  :volunteer_id, :options =>
        "CONSTRAINT fk_shift_volunteers REFERENCES volunteers(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :shifts
  end
end
