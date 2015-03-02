Rails.application.routes.draw do
  get 'annoucements/feed'
  	resources :annoucements
  devise_for :users, controllers: {registrations: "users"}
  resources :users
  root 'users#dashboard'
  get "/dashboard" => "users#dashboard"
  put "/users/:id" => "users#update"

  get "/organizations/new" => "organizations#new", as: "new_organization"
  post "/organizations" => "organizations#create"
end
