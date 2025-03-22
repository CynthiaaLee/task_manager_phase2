Rails.application.routes.draw do
  devise_for :users, path: 'api/users', controllers: {
    sessions: 'api/users/sessions',
    registrations: 'api/users/registrations'
  }, skip: [:passwords]
  
  devise_scope :user do
    post 'api/users/sign_in', to: 'api/users/sessions#create'
    delete 'api/users/sign_out', to: 'api/users/sessions#destroy'
    post 'api/users', to: 'api/users/registrations#create'
    post 'api/users/update_name', to: 'api/users#update_name'
  end

  namespace :api do
    resources :tasks
  end
end
