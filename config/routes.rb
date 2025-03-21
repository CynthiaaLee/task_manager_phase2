Rails.application.routes.draw do
  resources :tasks do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"
  root "tasks#index"
end
