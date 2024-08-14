class Answer < ApplicationRecord
    validates :answer_text, presence: true

    belongs_to :question
    has_many :user_answers, dependent: :destroy
end    