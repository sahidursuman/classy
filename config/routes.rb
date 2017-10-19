Rails.application.routes.draw do
  root "home_pages#index"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :users, only: :show

  namespace :my_page do
    resource :personal_information, only: [:edit, :update]
    resource :account_information, only: [:edit, :update]
  end

  resources :centers, only: :show do
    resources :branches, only: :index
  end

  resources :branches, only: :show do
    scope module: :branch do
      resources :reviews, only: [:index, :new, :create]
    end
  end

  resources :reviews, only: [:edit, :update, :destroy] do
    scope module: :review do
      resources :comments, only: :index
      resource :votes, only: [:create, :destroy]
    end
  end

  namespace :management do
    resources :branches, only: :index
  end
end
