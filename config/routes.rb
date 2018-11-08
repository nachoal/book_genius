Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  devise_for :users
  root to: 'pages#home'
  resources :books 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :static_pages
  get '/about', to: 'static_pages#about'
  get '/collection', to: 'static_pages#collection'
  get '/all_collections', to: 'static_pages#all_collections'
  get '/search_collections', to: 'static_pages#search_collections'
end
