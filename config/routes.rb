Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
  resources :posts, only: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"
end
