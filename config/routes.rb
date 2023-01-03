Rails.application.routes.draw do
  resources :jobs
  resources :sums
  resources :numbers
  resources :users

  get "/fetch", to: "jobs#fetch"

  post "/mpesa_callback", to: "users#mpesa_callback"
  post "/mpesa_index", to: "users#mpesa_index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
