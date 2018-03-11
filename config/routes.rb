Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#index'

  resources :books, only: %i[show index]
  resources :reviews, only: [:create]
  resources :orders, only: %i[index show]
  resources :order_items, only: %i[create update destroy]

  get 'cart', to: 'orders#cart', as: 'cart_page'
  post 'cart', to: 'orders#activate_coupon', as: 'activate_coupon'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, only: [:update] do
    collection do
      get 'settings', as: 'settings'
      patch 'update_password', to: 'users#update_password'
    end
  end

  get 'users/update_password', to: redirect('users/settings')
  get 'users/:id', to: redirect('users/settings')

  get 'checkout/start', to: 'checkout#start', as: 'checkout_start'
  get 'checkout(/:edit)', to: 'checkout#index', as: 'checkout'
  put 'checkout/edit_data', as: 'checkout_edit'
  get 'checkout/next_stage', to: redirect('checkout')
  put 'checkout/next_stage', as: 'checkout_next'
end
