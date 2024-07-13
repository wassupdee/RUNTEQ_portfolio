Rails.application.routes.draw do
  root 'top#index'
  resources :questions, only: [:show, :create]
  # get 'question1', to: 'q_and_a#question1'
  # get 'question2', to: 'q_and_a#question2'
  # get 'question3', to: 'q_and_a#question3'
  post 'answer1', to: 'questions#answer1'
  post 'answer2', to: 'questions#answer2'
  post 'answer3', to: 'questions#answer3'
  get 'openai', to: 'openai_api#chat'
end
