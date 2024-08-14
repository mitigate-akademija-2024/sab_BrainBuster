class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question_text, null: false
      t.references :quiz, foreign_key: true
      t.timestamps
    end
  end
end
