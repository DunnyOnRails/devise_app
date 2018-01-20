Rails.application.routes.draw do
  resources :posts
  resources :conversations
  resources :subjects
  resources :boards
  get 'pages/index'
  root 'pages#index'
  get 'pages/main'
  get 'open_pages/main'
  get 'open_pages/sign_up'
  get 'profiles/profile_details'
  get 'profiles/profile_summary'
  get 'profiles/profile_comments'
  get 'profiles/profile_history'
  get 'profiles/profile_settings'
  get 'profiles/profile_users'
  get 'profiles/profile_projects'
  post 'update_password' => 'profiles#update_password' # DD - custom method for updating devise password while logged in.
# DD - custom methods for creating and/or updating notifications records in profiles controller
  post 'create_update_notifications' => 'profiles#create_update_notifications'
  patch 'create_update_notifications' => 'profiles#create_update_notifications'
  get 'open_pages/testit'

  resources :profiles

  #devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}
end
