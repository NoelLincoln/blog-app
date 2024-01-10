Rails.application.routes.draw do
  get "users/:id" => "users#show", as: :user
  get "users/:user_id/posts" => "users/posts#index", as: :user_posts
  get "users/:user_id/posts/:id" => "users/posts#show", as: :user_post

  resources :users, only: [:index, :show] do
  resources :posts, only: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"
end
