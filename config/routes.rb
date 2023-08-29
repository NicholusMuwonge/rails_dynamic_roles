Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }

  namespace :users do
    resources :users
    resources :publishers
    resources :roles
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users/users#index"
end
