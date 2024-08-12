class ScoresController < ApplicationController
  before_action :set_quiz, only: [:index]

  def index
    @scores = @quiz.scores
  end

  def show
    @score = Score.find(params[:id])
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end
end
