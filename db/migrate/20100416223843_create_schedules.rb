class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.string :title
      t.integer :year
      t.text :description
      t.date :start
      t.date :end
      t.integer :shiftlength

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
