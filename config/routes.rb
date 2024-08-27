Rails.application.routes.draw do
  root 'static_pages#top'
  resources :introductions, only: [:show]
  resources :questions, only: [:show]
  resources :answers, only: [:create]
  resources :users, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :profiles do
    resources :events do
      collection do
        patch :update_all
      end
    end
    resources :albums
  end
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'ai_message', to: 'openai_api#show'
  post '/' => 'line_bot#save_line_id'

  get 'line_qr_code', to: 'static_pages#line_qr_code'
  get 'line_policy', to: 'static_pages#line_policy'

post "oauth/callback" => "oauths#callback"
get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :images, only: [:destroy]
end
