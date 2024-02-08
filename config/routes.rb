Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # get "/users", to: "users#index"
  # get "/vehicles", to: "vehicles#index"
  # get "/rentals", to: "rentals#index"
  # get "/show", to "users#show"
  resources :users, :except => [:create]
  resources :vehicles
  resources :rentals
  post '/signup', to: 'users#create'
  post '/login', to: 'auth#login'
  
end
