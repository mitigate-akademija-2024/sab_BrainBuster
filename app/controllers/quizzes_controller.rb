class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy fill ]
  before_action :authenticate_user!

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = current_user.quizzes  # Only show quizzes created by the current user
    @title = 'BrainBuster'
    @description = 'These are all your quizzes. Feel free to edit them and make new ones! :)'
  end

  # GET /start_quiz
  def start
    @quizzes = Quiz.all
    @title = 'Start a Quiz'
    @description = 'Choose a quiz to start:'
    
    respond_to do |format|
      format.html # renders start.html.erb
      format.json do
        render json: { title: @title, description: @description, quizzes: @quizzes }
      end
    end
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = current_user.quizzes.build(quiz_params)  # Associate the quiz with the current user
  
    respond_to do |format|
      if @quiz.save
        format.html do
          flash.notice = "Quiz was successfully created."
          redirect_to quiz_url(@quiz)
        end
        format.json { render :show, status: :created, location: @quiz }
      else
        flash.now.alert = 'Something went wrong'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy!

    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: "Quiz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /quizzes/1/fill
  def fill
    @questions = @quiz.questions.includes(:answers)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def quiz_params
    params.require(:quiz).permit(:title, :description)
  end
end
