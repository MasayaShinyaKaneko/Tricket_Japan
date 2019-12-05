Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#top'
  #users controller
  get '/users/about', to: 'users#about'
  get '/users/:id/unsubscribe', to: 'users#unsubscribe', as: "users_unsubscribe"
  patch '/users/:id/status_flag', to: 'users#status_flag'
  get '/users/unsubscribe/complete', to: 'users#complete'
  get '/users/:id/favorite', to: 'users#favorite', as: "user_favorite_page"
  patch '/users/:id/status_user', to: 'users#status_user'
  get '/users/travelers', to: 'users#index_traveler'
  get '/users/travelers/search', to: 'users#search_traveler'
  get '/users/locals', to: 'users#index_local'
  get '/users/locals/search', to: 'users#search_local'
  get '/users/locals/sort', to: 'users#sort_local'
  resources :users, only: [:show, :edit, :update] do
    resources :favorites, only:[:create, :destroy]
  end
  #posts controller
  get '/posts/top', to: 'posts#top'
  get '/posts/sort', to: 'posts#sort'
  resources :posts do
    resources :likes, only:[:create, :destroy]
  end
  patch '/posts/:id/status_display', to: 'posts#status_display'
  patch '/posts/:id/status_accomplish', to: 'posts#status_accomplish'
  #likes controller  →  posts controller下へ
  #favorites controller  →  users controller下へ

  #adminsファイル内のcontroller
  namespace :admins do
	  #admins/users controller
    get '/users/travelers', to: 'users#index_traveler'
    get '/users/travelers/search', to: 'users#search_traveler'
    get '/users/travelers/sort', to: 'users#travelers_local'
    get '/users/locals', to: 'users#index_local'
    get '/users/locals/search', to: 'users#search_local'
    get '/users/locals/sort', to: 'users#sort_local'
    patch '/users/:id/status_flag', to: 'users#status_flag'
	  resources :users, only: [:show, :edit, :update]
    #admins/posts controller
    get '/posts/search', to: 'posts#search'
    get '/posts/sort', to: 'posts#sort'
    patch '/posts/:id/status_flag', to: 'posts#status_flag'
    resources :posts, only:[:index, :show, :edit, :update]
  end
end