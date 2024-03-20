Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations' }
  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show, :create] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
        resources :comments, only: [:new, :create, :destroy]
        resources :likes, only: [:new, :create]
      end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
