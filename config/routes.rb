Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :customer, :path_names => { :sign_up => "register" }


  resource :customer, only: [:show] do
    resources :orders
    resources :billing_address, only: [:create], controller: 'address', action: 'create_billing_address'
    resources :shipping_address, only: [:create], controller: 'address'
    member do
      put 'change_email'
      put 'change_password'
      put 'remove_account'
    end
  end

  resources :books

  root 'main#home'
end
