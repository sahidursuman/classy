Rails.application.routes.draw do
  namespace :admin do
    root "home_pages#index", as: :root
    resources :centers, only: [:index, :new, :create]
  end
end
