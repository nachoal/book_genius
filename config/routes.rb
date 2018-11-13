Rails.application.routes.draw do
  root to: 'static_pages#about'
  devise_for :users

  resources :books do
    collection do
      get :search
      get :google_search
    end
  end

  resources :collections do
    resources :books, only: ['show']
  end

  resources :static_pages

  get '/about', to: 'static_pages#about'
  get '/collection', to: 'static_pages#collection'
  get '/all_collections', to: 'static_pages#all_collections'
  get '/search_collections', to: 'static_pages#search_collections'
end
