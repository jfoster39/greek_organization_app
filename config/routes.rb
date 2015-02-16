Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users"}
  resources :users
  root 'users#dashboard'
  get "/dashboard" => "users#dashboard"
  put "/users/:id" => "users#update"

  get "/organizations/new" => "organizations#new", as: "new_organization"
  post "/organizations" => "organizations#create"
end
