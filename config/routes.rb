Rails.application.routes.draw do
  root "home_pages#index"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :centers, only: :show do
    resources :branches, only: :index
  end

  resources :branches, only: :show do
    resources :reviews, only: [:index, :new, :create]
  end
end
