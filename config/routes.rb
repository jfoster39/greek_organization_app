Rails.application.routes.draw do
  devise_for :users
  resources :users
  root 'users#dashboard'
  get "/dashboard" => "users#dashboard"
  put "/users/:id" => "users#update"
end
