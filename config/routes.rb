# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :tags, only: %i[index show create] do
        get '/posts', to: 'tags#posts'
      end
      resources :users do
        resources :profiles, only: %i[index show update create]
        get :profile, to: 'profiles#show'
        put :profile, to: 'profiles#update'
      end
      resources :likes, only: %i[create destroy index]
      resources :messages, except: %i[index, show]
      resources :posts
      resources :conversations
      post 'conversations/add_user/:id', to: 'conversations#add_user'
      delete 'conversations/delete_user/:id', to: 'conversations#delete_user'
      resources :conversations do
        post 'add_user/:id', to: 'conversations#add_user'
        delete 'delete_user/:id', to: 'conversations#delete_user'
      end
      resources :profiles, only: %i[index show update create]
    end
  end
end
