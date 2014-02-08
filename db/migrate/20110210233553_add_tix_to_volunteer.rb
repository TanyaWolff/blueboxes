class AddTixToVolunteer < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :tix_students, :integer
    add_column :volunteers, :tix_kids, :integer
  end

  def self.down
    remove_column :volunteers, :tix_kids
    remove_column :volunteers, :tix_students
  end
end
