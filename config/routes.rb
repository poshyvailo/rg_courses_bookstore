Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  # devise_scope :customers do
  #   get '/sign_up', to: 'devise/registrations#new', as: :sing_up
  #   get '/sign_in', to: 'devise/sessions#new'
  #   get '/logout', to: 'devise/sessions#destroy'
  #   get '/forgot_password', to: 'devise/password#new'
  #   get '/reset_password', to: 'devise/password#edit'
  # end

  devise_for :customers,
             path_names: {sign_in: 'login', sign_out: 'logout'}

  get 'settings', to: 'customers#settings'
  get 'orders', to: 'customers#orders'

  root 'main#home'
end
