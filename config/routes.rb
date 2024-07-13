Rails.application.routes.draw do
  root 'top#index'
  resources :questions, only: [:show]
  resources :answers, only: [:create]
  get 'openai', to: 'openai_api#chat'
end
