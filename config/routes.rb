Rails.application.routes.draw do
  root to: 'books#index'
  devise_for :users
  resources :books
  resources :static_pages
  get '/about', to: 'static_pages#about'
  get '/collection', to: 'static_pages#collection'
  get '/all_collections', to: 'static_pages#all_collections'
  get '/search_collections', to: 'static_pages#search_collections'
end
