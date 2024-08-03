Rails.application.routes.draw do
  root 'static_pages#top'
  resources :introductions, only: [:show]
  resources :questions, only: [:show]
  resources :answers, only: [:create]
  resources :users, only: [:new, :create]
  resources :profiles do
    resources :events do
      collection do
        patch :update_all
      end
    end
  end
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'openai', to: 'openai_api#chat'
  post '/' => 'line_bot#save_line_id'

  get 'line_qr_code', to: 'static_pages#line_qr_code'
end
