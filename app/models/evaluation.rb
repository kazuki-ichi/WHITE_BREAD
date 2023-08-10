class Evaluation < ApplicationRecord
  belongs_to :white_bread_store
  belongs_to :user


  validates :comment, presence: true
  
end
