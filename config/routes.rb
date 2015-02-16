Rails.application.routes.draw do
  resources :users
  devise_for :users
  root 'users#dashboard'
  get "/dashboard" => "users#dashboard"
  put "/users/:id" => "users#update"
end
