Auth::Application.routes.draw do


  root to: "sessions#new"

  resources :booklusts
  resources :book_users
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  resources :identities
  # get '/auth/google_apps', to: "sessions#create"
end
