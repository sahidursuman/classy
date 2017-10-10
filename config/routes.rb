Rails.application.routes.draw do
  root "home_pages#index"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :training_centers, only: :show
end
