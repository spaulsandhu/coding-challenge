Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  get :login, to: "sessions#new"
  post :logout, to: "sessions#destroy"
  post :sessions, to: "sessions#create"

  root to: "sessions#new"
end
