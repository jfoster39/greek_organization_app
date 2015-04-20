Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users", omniauth_callbacks: "omniauth_callbacks"}
  devise_scope :user do
      get "/logout" => "devise/sessions#destroy"
  end
  root 'users#dashboard'

  #organization resources
  get "/users" => "organizations#users", as: "organization_users"
  get "/announcements" => "organizations#announcements", as: "organization_announcements"
  get "/calendar" => "organizations#calendar"
  get "/organizations/new" => "organizations#new", as: "new_organization"
  post "/organizations" => "organizations#create"

  #announcement resources
  patch "/announcements/:id" => "announcements#update"
  get "/announcements/new" => "announcements#new", as: "new_announcement"
  post "/announcements" => "announcements#create"
  get "/announcements/:id/edit" => "announcements#edit", as: "edit_announcement"
  delete "/announcements/:id" => "announcements#destroy", as: "destroy_announcement"
  get "/announcements/:id" => "announcements#show", as: "announcement"

  #user resources
  get "/dashboard" => "users#dashboard", as: "user_dashboard"
  patch "/users/:id" => "users#update"
  get "/users/new" => "users#new", as: "new_user"
  get "/users/:id/edit" => "users#edit", as: "edit_user"
  delete "/users/:id" => "users#destroy", as: "destroy_user"
  get "/users/:id/approve" => "users#approve", as: :approve_user
  get "/users/organization" => "users#edit_organization", as: "edit_user_organization"
  patch "/users_organization" => "users#update_organization"
  get "/documents" => "users#documents"
  get "/oauth2callback" => "users#new_google"

end
