class AddPictureIdToVolunteer < ActiveRecord::Migration
  def self.up
	add_column :volunteers, :picture_id, :integer

  end

  def self.down
	remove_column :volunteers, :picture_id
  end
end
