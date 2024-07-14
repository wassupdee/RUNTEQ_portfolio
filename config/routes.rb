Rails.application.routes.draw do
  root 'top#index'
  resources :introductions, only: [:show]
  resources :questions, only: [:show]
  resources :answers, only: [:create]
  get 'openai', to: 'openai_api#chat'
end
