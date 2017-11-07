Rails.application.routes.draw do
  root "home_pages#index"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :users, only: :show

  namespace :my_page do
    resource :personal_information, only: [:edit, :update]
    resource :account_information, only: [:edit, :update]
    resource :avatar, only: [:edit, :update]
  end

  resources :reviews, except: :index do
    scope module: :review do
      resources :comments, only: [:index, :new, :create]
      resource :votes, only: [:create, :destroy]
    end
  end

  resources :comments, only: [:edit, :update, :destroy]

  namespace :management do
    resources :branches, except: :destroy
    resources :review_verifications, only: [:index, :update]
    resource :center, only: [:edit, :update]
  end

  namespace :supports do
    resources :districts, only: :index
  end
end
