Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#index'

  devise_for :users, controllers: {
                      omniauth_callbacks: 'users/omniauth_callbacks',
                      sessions: 'users/sessions'
                    }

  resources :users, only: [:update] do
    collection do
      get 'settings', as: 'settings'
      patch 'update_password', to: 'users#update_password'
    end
  end

  resources :books, only: %i[show index]
  resources :reviews, only: [:create]
  resources :checkout, only: %i[index show update]

  resources :orders, only: %i[index show]
  get 'cart', to: 'orders#cart', as: 'cart_page'
  post 'cart', to: 'orders#activate_coupon', as: 'activate_coupon'

  resources :order_items, only: %i[create update destroy]

  get 'users/update_password', to: redirect('users/settings')
  get 'users/:id', to: redirect('users/settings')

end
