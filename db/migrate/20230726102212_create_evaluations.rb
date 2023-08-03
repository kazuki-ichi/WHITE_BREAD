class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.integer :taste
      t.integer :sweetness
      t.integer :comment
      t.integer :texture
      t.integer :white_bread_store_id
      t.integer :user_id

      t.timestamps
    end
  end
end
