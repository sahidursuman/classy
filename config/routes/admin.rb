Rails.application.routes.draw do
  namespace :admin do
    root "users#index", as: :root
    resources :centers, only: [:index, :new, :create]
    resources :reports, only: [:index, :edit, :update]
    resources :users, only: [:index, :new, :create]
    resources :categories, only: :index
    resources :cities, only: :index
    resources :districts, only: :index
  end
end
