# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :profiles, only: %i[index show update create]
      resources :posts  do
        post '/add_tag', to: 'posts#add_tag'
        delete '/remove_tag/:id', to: 'posts#remove_tag'
      resources :tags, only: %i[index show create] do
        get '/posts', to: 'tags#posts'
      end
      resources :users do
        resources :profiles, only: %i[index show update create]
        get :subscribers, to: 'user_subscriptions#subscribers'
        get :subscriptions, to: 'user_subscriptions#subscriptions'
        post :subscribe, to: 'user_subscriptions#subscribe'
        post :unsubscribe, to: 'user_subscriptions#unsubscribe'
      end
      resources :likes, only: %i[create destroy index]
      resources :messages, except: %i[index, show]
      resources :conversations do
        post 'add_user/:user_id', to: 'conversations#add_user'
        delete 'delete_user/:user_id', to: 'conversations#delete_user'
      end
      resources :profiles, only: %i[index show update create]
      get '/search' => 'profiles#search'
    end
  end
end