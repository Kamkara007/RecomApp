Rails.application.routes.draw do
  resources :registrations, only: [:show, :update, :create]


  devise_for :users
  
  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
