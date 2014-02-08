class AddPrefToVolunteer < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :early, :integer
    add_column :volunteers, :late, :integer
    add_column :volunteers, :dinner, :integer
    add_column :volunteers, :best_loc, :integer
    add_column :volunteers, :worst_loc, :integer
    add_column :volunteers, :gate, :boolean
    add_column :volunteers, :inner, :boolean
  end

  def self.down
    remove_column :volunteers, :inner
    remove_column :volunteers, :gate
    remove_column :volunteers, :worst_loc
    remove_column :volunteers, :best_loc
    remove_column :volunteers, :dinner
    remove_column :volunteers, :late
    remove_column :volunteers, :early
  end
end
