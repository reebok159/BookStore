Rails.application.routes.draw do

  get 'users/profile'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'pages#index'


  get 'catalog', to: 'books#catalog'
  get 'spry', to: 'pages#spry'


  resources :books


  get 'books/:id/destroy', to: 'books#destroy', as: 'book_destroy'
  #get 'book/show', to: 'books#show', as: 'show_book'
  get 'books(/catid/:catid)(/order/:order)(/test/:test)', to: 'books#index'
  post 'to_cart/(:item_id)/(:quantity)', to: 'order_items#create', as: 'to_cart'
  post 'clear_cart', to: 'orders#clear_cart', as: 'clear_cart'
  get 'cart', to: 'orders#cart', as: 'cart_page'
  #get 'books/new'

  #get 'books/create'

  #get 'books/edit(/:id)(/.:format)', to: 'books#edit', as: 'book_delete'

  #get 'books/update'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'pages/index'
end
