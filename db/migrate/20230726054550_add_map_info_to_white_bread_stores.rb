class AddMapInfoToWhiteBreadStores < ActiveRecord::Migration[6.1]
  def change
    add_column :white_bread_stores, :address, :string
    add_column :white_bread_stores, :latitude, :float
    add_column :white_bread_stores, :longitude, :float
  end
end
