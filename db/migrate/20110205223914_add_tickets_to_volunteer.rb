class AddTicketsToVolunteer < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :tickets, :integer
  end

  def self.down
    remove_column :volunteers, :tickets
  end
end
