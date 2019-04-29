Rails.application.routes.draw do
  resources :books
  devise_for :users
  resources :users
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  root 'top#index'
  get   'index' => 'top#index-about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
