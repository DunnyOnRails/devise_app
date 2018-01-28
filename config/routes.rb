Rails.application.routes.draw do
  # Admin routes
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Profile routes
    resources :profiles
  # Posts routes
    resources :posts
  # Conversation routes
    resources :conversations
  # Subjects routes
    resources :subjects
  # Pages routes
    get 'pages/index'
    root 'pages#index'
    get 'pages/main'
    get 'pages' => 'pages#index'
  # Open_pages routes
    get 'open_pages' => 'pages#index'
    get 'open_pages/index' => 'pages#index'
    get 'open_pages/main'
    get 'open_pages/sign_up'
  # Profile routes
    get 'profiles/profile_details'
    get 'profiles/profile_summary'
    get 'profiles/profile_comments'
    get 'profiles/profile_history'
    get 'profiles/profile_settings'
    get 'profiles/profile_users'
    get 'profiles/profile_projects'
      # Profile routes
      resources :profiles
  # Custom methods for creating and/or updating notifications records in profiles controller
    post 'create_update_notifications' => 'profiles#create_update_notifications'
    patch 'create_update_notifications' => 'profiles#create_update_notifications'
    get 'open_pages/testit'
  # Boards routes - this is pointing pages/boards to pages/boards controller
    namespace :pages do
      resources :boards
    end
  # Devise routes
  devise_for :users, :controllers => {:registrations => "registrations"}
  post 'update_password' => 'profiles#update_password' # DD - custom method for updating devise password while logged in.
end
