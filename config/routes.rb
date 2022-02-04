# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        resources :profiles, only: %i[index show update create]
        get :subscribers, to: 'user_subscriptions#subscribers'
        get :subscriptions, to: 'user_subscriptions#subscriptions'
        post :subscribe, to: 'user_subscriptions#subscribe'
        post :unsubscribe, to: 'user_subscriptions#unsubscribe'
      end
      resources :posts
      resources :likes, only: %i[create destroy index]
    end
  end
end