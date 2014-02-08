class AddAvailabilityToVolunteer < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :friday_pm, :boolean
    add_column :volunteers, :monday_am, :boolean
    add_column :volunteers, :monday_pm, :boolean
    add_column :volunteers, :old_hat, :boolean
    add_column :volunteers, :first_year_bs, :integer
    add_column :volunteers, :first_year_key, :integer
  end

  def self.down
    remove_column :volunteers, :first_year_key
    remove_column :volunteers, :first_year_bs
    remove_column :volunteers, :old_hat
    remove_column :volunteers, :monday_pm
    remove_column :volunteers, :monday_am
    remove_column :volunteers, :friday_pm
  end
end
