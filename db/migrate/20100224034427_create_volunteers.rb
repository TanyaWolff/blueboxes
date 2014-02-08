class CreateVolunteers < ActiveRecord::Migration
  def self.up
    create_table :volunteers do |t|
      t.string :name
      t.string :email
      t.string :profile
      t.string :hashed_pw
      t.string :salt
      t.boolean :key
      t.boolean :hat
      t.integer :hours, :default => 10
      t.string :restrictions
      t.string :shiftlength

      t.timestamps
    end
  end

  def self.down
    drop_table :volunteers
  end
end
