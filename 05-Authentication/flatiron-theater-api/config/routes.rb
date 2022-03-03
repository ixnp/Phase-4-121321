Rails.application.routes.draw do
  resources :tickets, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:create]
  # resources :production_roles
  resources :productions, only: [:index, :show, :create, :update, :destroy]

  #/login
  # to sessions controller
  # to action login
  post "/login", to: "sessions#login"
end
