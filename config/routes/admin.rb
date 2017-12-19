Rails.application.routes.draw do
  namespace :admin do
    root "home_pages#index", as: :root
    resources :centers, only: [:index, :new, :create]
    resources :reports, only: [:index, :edit, :update]
    resources :users, only: [:index, :new, :create]
  end
end
