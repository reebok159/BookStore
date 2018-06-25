# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    put 'update_address', to: 'users/registrations#update_address'
  end

  resources :books, only: %i[show index]
  resources :reviews, only: [:create]
  resources :checkout, only: %i[index show update]
  resources :orders, only: %i[index show]
  resources :order_items, only: %i[create update destroy]

  get 'cart', to: 'orders#cart', as: 'cart_page'
  post 'cart', to: 'orders#activate_coupon', as: 'activate_coupon'
end
