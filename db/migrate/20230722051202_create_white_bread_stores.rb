class CreateWhiteBreadStores < ActiveRecord::Migration[6.1]
  def change
    create_table :white_bread_stores do |t|
      t.string :name
      t.string :detail
      t.integer :price
      t.integer :image_path
      t.string :user_id
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
