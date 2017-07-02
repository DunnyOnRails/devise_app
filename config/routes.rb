Rails.application.routes.draw do
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

  resources :profiles

  #devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#devise_for :users, :path => '', :path_names => { :sign_in => "open_pages/index" }

  # For detls on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
