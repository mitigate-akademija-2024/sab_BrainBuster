class AddScoreIdToUserAnswers < ActiveRecord::Migration[7.1]
  def change
    add_column :user_answers, :score_id, :integer
  end
end
