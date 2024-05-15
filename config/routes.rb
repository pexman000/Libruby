Rails.application.routes.draw do
  resources :books
  resources :books, except: [:show] do
    resources :borrows, only: [:create]
  end
  resources :transactions
  get 'cart_items/create'
  get 'cart_items/update'
  get 'cart_items/destroy'
  get 'orders/create'
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/create'
  get 'products/edit'
  get 'products/update'
  get 'products/destroy'
  root 'books#index'
  resources :registrations
  resources :sessions, only: [:new, :create]
  resources :posts do
    resources :comments do
      get '/add', to: 'comments#new', as: :add_child_comment
      post '/', to: 'comments#create', as: :add_child_comment_parent
    end
  end
  resources :comments
  resources :users
  resources :books do
    patch :borrow, on: :member
    patch :return, on: :member
  end
  resources :buyers
  resources :sellers
  delete 'logout' => 'sessions#destroy', as: :logout
  get "up" => "rails/health#show", as: :rails_health_check


end
