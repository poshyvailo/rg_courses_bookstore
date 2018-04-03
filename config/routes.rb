Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :customer, controllers: {
      omniauth_callbacks: 'customers/omniauth_callbacks',
      registrations: 'customers/registrations'
  }

  resource :customers, only: [:show, :update] do
    resources :orders, only: [:index, :show]
    member do
      put 'change_email'
      put 'change_password'
      put 'remove_account'
      # put 'update_billing_address'
      # put 'update_shipping_address'
    end
  end

  resource :catalog, only: [:show] do
    resources :category, only: [:show]
    resources :book, only: [:show]
  end

  resource :cart, only: [:show, :update]
  resources :order_item, only: [:create, :update]

  resources :orders, only: [:index, :show] do
    resources :checkout, only: [:index, :show, :update]
  end

  root 'main#home'
end
