Rails.application.routes.draw do
  # resources :tickets
  resources :users, only: [:create]
  # resources :production_roles
  resources :productions, only: [:index, :show, :create, :update, :destroy]

end
