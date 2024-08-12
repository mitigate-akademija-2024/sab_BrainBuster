Rails.application.routes.draw do
  root 'quizzes#index'

  get "/start_quiz", to: "quizzes#start"

  resources :quizzes do
    member do
      get :show_score  # Route to show the score after submitting the quiz
      get :fill
      post :submit
    end

    resources :questions, shallow: true
    resources :scores, only: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end


