Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users"}
  devise_scope :user do
      get "/logout" => "devise/sessions#destroy"
  end
  root 'users#dashboard'
  get "/dashboard" => "users#dashboard"
  get "/users" => "organizations#users", as: "organization_users"

  #user resources
  put "/users/:id" => "users#update"
  get "/users/new" => "users#new", as: "new_user"
  get "/users/:id/edit" => "users#edit", as: "edit_user"
  delete "/users/:id" => "users#destroy", as: "destroy_user"
  get "/users/:id/approve" => "users#approve", as: :approve_user

  get "/calendar" => "users#calendar"
  get "/documents" => "users#documents"

  get "/organizations/new" => "organizations#new", as: "new_organization"
  post "/organizations" => "organizations#create"
end
