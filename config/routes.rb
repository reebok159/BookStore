Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #temporaly
  get 'spry', to: 'pages#spry'
  #temporaly

  root 'pages#index'

  resources :books, only: [:show, :index]
  get 'catalog', to: 'books#catalog'
  get 'books(/catid/:catid)(/order/:order)', to: 'books#index'
  put 'reviews/create'

  #order_items
  resources :order_items, except: [:edit, :show]

  post 'to_cart/(:item_id)/(:quantity)', to: 'order_items#create', as: 'to_cart'

  get 'cart', to: 'orders#index', as: 'cart_page'
  post 'cart', to: 'orders#activate_coupon', as: 'activate_coupon'

  #profile
  get 'users/settings'
  get 'users/orders'
  #get 'users/(:id)', to: redirect('users/settings')
  patch 'users/update_password', to: 'users#update_password'
  get 'users/update_password', to: redirect('users/settings')

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:update]

  get 'checkout/start', to: 'checkout#start', as: 'checkout_start'
  get 'checkout(/:edit)', to: 'checkout#index', as: 'checkout'
  put 'checkout/edit_data', as: 'checkout_edit'
  get 'checkout/next_stage', to: redirect('checkout')
  put 'checkout/next_stage', as: 'checkout_next'

end
