class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :white_bread_store
  
  validates_uniqueness_of :user_id, scope: :white_bread_store_id
end
