Rails.application.routes.draw do

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :categories do
    resources :books, only: [:show, :index] do
      resources :comments, only: [:create, :destroy]
    end
  end
  namespace :admin do
    resources :books, except: [:new, :edit]
    resources :requests
    resources :categories
    get "/",     to: "sessions#new"
    post "/login",    to: "sessions#create"
  end
  resources :authors
  resources :publishers
  resources :requests
  resources :likes, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  get "users/new"
  root "static_pages#home"
  get "/signup",  to: "users#new"
  post '/signup',  to: 'users#create'
  get "/help",    to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get '/search', to: 'static_pages#search'
end
