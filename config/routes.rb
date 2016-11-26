Rails.application.routes.draw do
  root to: 'home#index'

  resources :maps

  get '/contact', to: 'home#contact'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
