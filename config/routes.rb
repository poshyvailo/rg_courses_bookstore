Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :customer, :path_names => { :sign_up => "register" }

  resource :customer do
    resource :orders
    resource :settings do
      member do
        put 'change_email'
      end
    end
  end

  root 'main#home'
end
