Rails.application.routes.draw do
  root "home_pages#index"
  get '/404', :to => redirect("/404.html")

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only: :show

  namespace :my_page do
    resource :personal_information, only: [:edit, :update]
    resource :account_information, only: [:edit, :update]
    resource :avatar, only: [:edit, :update]
    resource :password, only: [:edit, :update]
  end

  resources :reviews, except: :index do
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
    resources :courses, except: [:index, :show, :destroy]
  end

  namespace :supports do
    resources :districts, only: :index
    resources :categories, only: :index
  end

  namespace :search do
    resources :centers, only: :index
    resources :url_makers, only: :index
  end
end
