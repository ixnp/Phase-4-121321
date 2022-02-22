Rails.application.routes.draw do
  # resources :production_roles
  # resources :tickets
  # resources :users
  resources :productions, only: [:index, :show]
  #route login
  #controller sessions 
  #action index 
  # get '/login', to: "sessions#index"
end
