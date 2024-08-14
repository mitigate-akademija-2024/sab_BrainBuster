class Question < ApplicationRecord
    validates :question_text, presence: true
  
    belongs_to :quiz
    has_many :answers, dependent: :destroy
    has_many :user_answers, dependent: :destroy
    
    accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes['answer_text'].blank? }

    validate :validate_answers

    def validate_answers
      errors.add(:answers, :too_few, message: "at least too answers needed") if answers.select { | ans| !ans.marked_for_destruction? }.count < 2
      errors.add(:answers, :no_correct, message: "at least one correct answer needed") if answers.none? { |ans| ans.correct? }
    end
  end
  