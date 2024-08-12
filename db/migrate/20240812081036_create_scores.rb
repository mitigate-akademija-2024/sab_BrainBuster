class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :quiz, null: false, foreign_key: true
      t.integer :score, null: false

      t.timestamps
    end
  end
end
