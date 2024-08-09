class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]

  def index
  end

  def create
    @question = @quiz.questions.new(question_params)
  
    if params[:commit] == "add_answer"
      @question.answers.new
      render :new, status: :unprocessable_entity
    elsif @question.save
      flash.notice = "Question was successfully created."
      redirect_to quiz_url(@quiz)
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def new
    @question = @quiz.questions.new
  end

  def add_answer
    @question = @quiz.questions.new(question_params)
    @question.answers.new
    render :new
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:question_text, answers_attributes: [:id, :answer_text, :correct])
  end
end