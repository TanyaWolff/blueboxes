class AddAddressToVolunteer < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :address, :string
  end

  def self.down
    remove_column :volunteers, :address
  end
end
