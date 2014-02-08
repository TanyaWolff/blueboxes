class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.integer :volunteer_id
      t.integer :year
      t.integer :tix_ad
      t.integer :tix_st
      t.integer :tix_ch

      t.timestamps
    end
  end

  def self.down
    drop_table :signups
  end
end
