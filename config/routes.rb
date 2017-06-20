Rails.application.routes.draw do
  get 'open_pages/index'
  get 'pages/index'
  root 'pages#index'
  get 'pages/main'
  get 'open_pages/main'
  get 'open_pages/main_content'
  get 'open_pages/jquerytest'
  get 'open_pages/sign_up'

  #devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#devise_for :users, :path => '', :path_names => { :sign_in => "open_pages/index" }

  # For detls on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
