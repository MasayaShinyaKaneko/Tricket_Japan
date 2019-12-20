Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
  }

  root to: 'users#top'
  #users controller
  get '/users/:id/unsubscribe', to: 'users#unsubscribe', as: "users_unsubscribe"
  get '/users/unsubscribe/complete', to: 'users#complete'
  get '/users/:id/favorite', to: 'users#favorite', as: "user_favorite_page"
  patch '/users/:id/status_user', to: 'users#status_user', as: "user_status"
  get '/users/travelers', to: 'users#index_traveler'
  get '/users/travelers/search', to: 'users#search_traveler'
  get '/users/locals', to: 'users#index_local'
  get '/users/locals/search', to: 'users#search_local'
  get '/users/locals/sort', to: 'users#sort_local'
  resources :users, only: [:show, :edit, :update, :destroy]
  #posts controller
  get '/posts/top', to: 'posts#top'
  get '/posts/sort', to: 'posts#sort'
  resources :posts do
    resources :likes, only:[:create, :destroy]
    resources :comments, only: [:create]
  end
  patch '/posts/:id/status_display', to: 'posts#status_display'
  patch '/posts/:id/status_accomplish', to: 'posts#status_accomplish', as: "status_accomplish"
  patch '/posts/:id/update_accomplish', to: 'posts#update_accomplish', as: "update_accomplish"
  patch '/posts/:id/reset_accomplish', to: 'posts#reset_accomplish', as: "reset_accomplish"
  #comments controller + 一部posts controller下へ
  resources :comments, only: [:edit, :update, :destroy]
  #likes controller  →  posts controller下へ
  #favorites controller
  resources :favorites, only: [:create, :destroy]
  #room controller
  resources :rooms, :only => [:create, :show, :index]
  #message controller
  resources :messages, :only => [:create]
  #contact controller
  resources :contacts, only: [:new, :create]
  #notification controller
  resources :notifications, only: [:index]

  #adminsファイル内のcontroller
  namespace :admins do
	  #admins/users controller
    get '/users/travelers', to: 'users#index_traveler'
    get '/users/travelers/search', to: 'users#search_traveler'
    get '/users/travelers/sort', to: 'users#sort_traveler'
    get '/users/locals', to: 'users#index_local'
    get '/users/locals/search', to: 'users#search_local'
    get '/users/locals/sort', to: 'users#sort_local'
    patch '/users/:id/restore', to: 'users#restore', as: "user_restore"
	  resources :users, only: [:show, :edit, :update, :destroy]
    #admins/posts controller
    get '/posts/search', to: 'posts#search'
    get '/posts/sort', to: 'posts#sort'
    patch '/posts/:id/restore', to: 'posts#restore', as: "post_restore"
    resources :posts, only:[:index, :show, :destroy]
    delete '/comments/:id', to: 'posts#comment_destroy', as: "comment_delete"
    #admins/contacts controller
    get '/contacts/search', to: 'contacts#search'
    resources :contacts, only:[:index, :show, :update]
  end
end