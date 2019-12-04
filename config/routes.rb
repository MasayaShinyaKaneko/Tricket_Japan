Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#top'
  #users controller
  resources :users, only: [:show] do
    resources :favorites, only:[:create, :destroy]
  end
  get '/users/:id/unsubscribe', to: 'users#unsubscribe'
  patch '/users/:id/status_flag', to: 'users#status_flag'
  get '/users/:id/unsubscribe/complete', to: 'users#complete'
  get '/users/:id/favorite', to: 'users#favorite'
  patch '/users/:id/status_user', to: 'users#status_user'
  get '/users/travelers', to: 'users#index_traveler'
  get '/users/travelers/search', to: 'users#search_traveler'
  get '/users/locals', to: 'users#index_local'
  get '/users/locals/search', to: 'users#search_local'
  get '/users/locals/sort', to: 'users#sort_local'
  #posts controller
  resources :posts do
    resources :likes, only:[:create, :destroy]
  end
  get '/posts/top', to: 'posts#top'
  get '/posts/sort', to: 'posts#sort'
  patch '/posts/:id/status_display', to: 'posts#status_display'
  patch '/posts/:id/status_accomplish', to: 'posts#status_accomplish'
  #likes controller  →  posts controller下へ
  #favorites controller  →  users controller下へ

  #adminsファイル内のcontroller
  namespace :admins do
	  #admins/users controller
	  resources :users, only: [:show, :edit, :update]
	  get '/users/travelers', to: 'users#index_traveler'
	  get '/users/travelers/search', to: 'users#search_traveler'
	  get '/users/travelers/sort', to: 'users#travelers_local'
	  get '/users/locals', to: 'users#index_local'
	  get '/users/locals/search', to: 'users#search_local'
	  get '/users/locals/sort', to: 'users#sort_local'
      patch '/users/:id/status_flag', to: 'users#status_flag'
      #admins/posts controller
      resources :posts, only:[:index, :show, :edit, :update]
      get '/posts/search', to: 'posts#search'
      get '/posts/sort', to: 'posts#sort'
      patch '/posts/:id/status_flag', to: 'posts#status_flag'
  end
end