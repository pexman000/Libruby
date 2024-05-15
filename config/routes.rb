Rails.application.routes.draw do
  resources :books
  resources :books, except: [:show] do
    resources :borrows, only: [:create]
  end
  root 'books#index'
  resources :registrations
  resources :sessions, only: [:new, :create]
  resources :users
  resources :books do
    patch :borrow, on: :member
    patch :return, on: :member
  end
  delete 'logout' => 'sessions#destroy', as: :logout
end
