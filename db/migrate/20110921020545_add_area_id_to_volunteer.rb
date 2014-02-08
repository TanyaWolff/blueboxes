class AddAreaIdToVolunteer < ActiveRecord::Migration
  def self.up
   add_column :volunteers, :area_id, :integer
  end

  def self.down
    remove_column :volunteers, :area_id
  end
end
