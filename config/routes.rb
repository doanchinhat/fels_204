Rails.application.routes.draw do
  root "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"
  resources :users do
    resources :following, only: :index
    resources :followers, only: :index
  end
  namespace :admin do
    resources :categories
    resources :words, except: :show
    resources :users, except: :show
  end

  resources :categories do
    resources :lessons
  end
  resources :words, only: :index
  resources :relationships, only: [:create, :destroy]
end
