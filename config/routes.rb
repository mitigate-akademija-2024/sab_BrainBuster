Rails.application.routes.draw do
  devise_for :users
  root 'quizzes#index'

  get "/start_quiz", to: "quizzes#start"

  resources :quizzes do
    member do
      get :fill  # Route to fill out a quiz with answers
    end

    resources :questions, shallow: true

    resources :scores, only: [:show] do
      collection do
        post :submit  # For submitting answers and calculating the score
      end
    end

    resources :user_answers, only: [] do
      collection do
        post :submit  # For saving user answers
      end
    end
  end

  # Add the leaderboard route
  get "/leaderboard", to: "leaderboards#index", as: :leaderboard

  get "up" => "rails/health#show", as: :rails_health_check
end



