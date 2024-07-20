Rails.application.routes.draw do
  root 'top#index'
  resources :introductions, only: [:show]
  resources :questions, only: [:show]
  resources :answers, only: [:create]
  resources :users, only: [:new, :create]
  resources :profiles
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'openai', to: 'openai_api#chat'
  post '/' => 'line_bot#line_id_registration'
end
