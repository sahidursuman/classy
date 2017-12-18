Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  root "home_pages#index"
  get '/404', :to => redirect("/404.html")

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :my_page do
    resource :profile, only: [:edit, :update]
    resource :account, only: [:edit, :update]
    resource :password, only: [:edit, :update]
    resources :reports, only: [:index, :destroy]
    resources :notifications, only: [:index]
  end

  resources :reviews, only: [:edit, :update, :destroy] do
    scope module: :review do
      resources :comments, only: [:index, :new, :create]
      resource :votes, only: [:create, :destroy]
    end
  end

  resources :comments, only: [:edit, :update, :destroy]
  resources :reports, only: [:new, :create]

  namespace :management do
    resources :branches, except: :destroy
    resources :review_verifications, only: [:index, :update]
    resource :center, only: [:edit, :update]
    resources :courses, except: [:show, :destroy]
    namespace :verification do
      resources :reviews, only: [:index, :update]
    end
  end

  namespace :supports do
    resources :districts, only: :index
    resources :categories, only: :index
  end

  namespace :search do
    resources :centers, only: :index
    resources :url_makers, only: :index
  end

  resources :users, only: :show do
    scope module: :user do
      resources :reviews, only: :index
    end
  end
end
