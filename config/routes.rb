Rails.application.routes.draw do
  root "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"
  resources :users
  resources :categories, only: :index
  namespace :admin do
    resources :categories, only: [:index, :destroy]
  end
end
