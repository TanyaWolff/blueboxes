class AddAreaIdToLocation < ActiveRecord::Migration
  def self.up
   add_column :locations, :area_id, :integer
  end

  def self.down
    remove_column :locations, :area_id

  end
end

