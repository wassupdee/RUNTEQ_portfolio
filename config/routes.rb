Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'static_pages#top'
  resources :introductions, only: [:show]
  resources :questions, only: [:show]
  resources :answers, only: [:create]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :profiles do
    resources :events do
      collection do
        patch :update_all
      end
    end
    resources :albums
  end
  resources :calendars, only: [:index]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'ai_message', to: 'openai_api#show'

  get 'line_qr_code', to: 'static_pages#line_qr_code'
  get 'line_policy', to: 'static_pages#line_policy'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms', to: 'static_pages#terms'
  get 'how_to_use', to: 'static_pages#how_to_use'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :images, only: [:destroy]
end
