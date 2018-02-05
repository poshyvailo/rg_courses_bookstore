Rails.application.routes.draw do
  devise_for :customers
  # resources :categories
  root 'main#home'
end
