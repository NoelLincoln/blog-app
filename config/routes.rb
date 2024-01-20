Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations' }
  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
        resources :comments, only: [:new, :create, :destroy]
        resources :likes, only: [:new, :create]
      end
  end

  post "users/:id/generate_token" => "users#generate_token", as: :generate_token

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index, :create] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end


  get "up" => "rails/health#show", as: :rails_health_check
end
