Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :customer


  resource :customer, only: [:show] do
    resources :orders
    member do
      put 'change_email'
      put 'change_password'
      put 'remove_account'
      put 'update_billing_address'
      put 'update_shipping_address'
    end
  end

  resource :catalog, only: [:show] do
    resources :category, only: [:show]
    resources :book, only: [:show]
  end

  root 'main#home'
end
