class Score < ApplicationRecord
  belongs_to :quiz
  belongs_to :user
  has_many :user_answers

end