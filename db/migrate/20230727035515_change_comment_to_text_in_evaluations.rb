class ChangeCommentToTextInEvaluations < ActiveRecord::Migration[6.1]
  def change
    change_column :evaluations, :comment, :text
  end
end

