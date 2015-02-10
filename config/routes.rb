Rails.application.routes.draw do
  devise_for :users
  root 'users#dashboard'
  get "/dashboard" => "users#dashboard"
  get "/users" => "users#users"
end
