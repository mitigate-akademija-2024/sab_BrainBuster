class LeaderboardsController < ApplicationController
  def index
    if params[:quiz_id]
      @quiz = Quiz.find(params[:quiz_id])
      @top_scores = Score.joins(:user)
                         .where(quiz: @quiz)
                         .select('users.email, scores.score')
                         .order(score: :desc)
                         .limit(10)
    else
      @top_scores = Score.joins(:user, :quiz)
                         .select('users.email, scores.score, quizzes.title AS quiz_title')
                         .order(score: :desc)
                         .limit(10)
    end
  end
end
