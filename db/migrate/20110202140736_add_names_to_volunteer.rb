class AddNamesToVolunteer < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :first_name, :string
    add_column :volunteers, :last_name, :string
  end

  def self.down
    remove_column :volunteers, :last_name
    remove_column :volunteers, :first_name
  end
end
