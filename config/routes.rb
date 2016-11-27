Rails.application.routes.draw do
  root to: 'home#index'

  resources :maps
  resources :broadcasts, path: :news
  resources :reviews

  resources :areas

  get '/contact', to: 'home#contact'
  get '/about', to: 'home#about'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
