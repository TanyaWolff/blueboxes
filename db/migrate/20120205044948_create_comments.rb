class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :entry
      t.integer :volunteer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
