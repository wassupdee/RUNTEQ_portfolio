Rails.application.routes.draw do
  root 'top#index'
  get 'question1', to: 'q_and_a#question1'
  get 'question2', to: 'q_and_a#question2'
  get 'question3', to: 'q_and_a#question3'
  post 'answer1', to: 'q_and_a#answer1'
  post 'answer2', to: 'q_and_a#answer2'
  post 'answer3', to: 'q_and_a#answer3'
  get 'openai', to: 'openai_api#chat'
end
