class AddArtworkFields < ActiveRecord::Migration
  def self.up
    add_column :assets, :artwork_medium, :string
    add_column :assets, :measurements,   :string
  end
  
  def self.down
    remove_column :assets, :artwork_medium
    remove_column :assets, :measurements
  end
end