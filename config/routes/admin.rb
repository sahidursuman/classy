Rails.application.routes.draw do
  namespace :admin do
    root "home_pages#index", as: :root
  end
end
