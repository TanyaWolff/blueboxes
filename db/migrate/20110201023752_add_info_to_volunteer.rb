class AddInfoToVolunteer < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :phone, :string
    add_column :volunteers, :cell, :string
    add_column :volunteers, :share, :boolean
    add_column :volunteers, :thursday, :boolean

  end

  def self.down
    remove_column :volunteers, :cell
    remove_column :volunteers, :phone
    remove_column :volunteers, :share
    remove_column :volunteers, :thursday
  end
end
