Rails.application.routes.draw do
  root to: 'home#index'

  resources :maps

  get '/contact', to: 'home#contact'
  get '/about', to: 'home#about'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
