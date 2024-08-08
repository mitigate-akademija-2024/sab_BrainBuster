class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]
  def index
  end

  def create
    
  end

  def new
    @Quiz = Quiz.find(params[:quiz_id])
    @Question = @quiz.questions.new
  end

  private

  def set_quiz
    @quiz= Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:question_text)
  end

end
