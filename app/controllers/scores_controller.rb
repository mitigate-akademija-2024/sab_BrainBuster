class ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz, only: [:submit, :show]
  before_action :set_score, only: [:show]

  # POST /quizzes/:quiz_id/scores
  def submit
    submitted_answers = params[:answers] || {}
  
    # Calculate the score
    score_value = calculate_score(@quiz, submitted_answers)
  
    # Create a Score record for the user
    score = @quiz.scores.create!(user: current_user, score: score_value)
  
    # Iterate over each submitted answer
    submitted_answers.each do |question_id, answer_ids|
      # Convert answer_ids to an array and remove any "0" values
      filtered_answer_ids = Array(answer_ids).reject { |id| id == "0" }
  
      # Create a UserAnswer for each selected answer
      filtered_answer_ids.each do |answer_id|
        answer = Answer.find(answer_id)
  
        UserAnswer.create!(
          user: current_user,
          quiz: @quiz,
          question_id: question_id,
          answer_id: answer_id,
          score_id: score.id # Associate the UserAnswer with the newly created score
        )
      end
    end
  
    # Redirect to the score page with a success notice
    redirect_to quiz_score_path(@quiz, score), notice: "Your answers have been submitted."
  end
  
  
  def show
    @score = @quiz.scores.find(params[:id])
  
    # Fetch user answers associated with this specific score
    @user_answers = UserAnswer
                      .where(quiz: @quiz, user: current_user, score: @score)
                      .group_by(&:question_id)
  end
  
  
  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_score
    @score = @quiz.scores.find(params[:id])
  end

  # This method calculates the user's score based on their answers
  def calculate_score(quiz, submitted_answers)
    correct_answers_count = 0
  
    quiz.questions.each do |question|
      selected_answers = submitted_answers[question.id.to_s] || []
  
      # Clean up the selected answers: remove stray characters and filter out invalid entries
      selected_answers = selected_answers.map do |answer|
        answer.gsub(/[\[\]\"]/, '') 
      end.reject { |id| id.blank? || id == "0" } 
  
      # Get the correct answers for the current question
      correct_answers = question.answers.where(correct: true).pluck(:id).map(&:to_s)
  
      # Increment the count if selected answers exactly match the correct answers
      correct_answers_count += 1 if selected_answers.sort == correct_answers.sort
    end
  
    correct_answers_count
  end 
end
