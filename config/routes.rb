Rails.application.routes.draw do
  get 'open_pages/index'

  get 'pages/index'
  root 'pages#index'
  get 'pages/main'
  get 'open_pages/sign_up'
  devise_for :users

  # For detls on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
