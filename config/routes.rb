Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for "User", at: "auth"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :profiles, only: %i[index show update create]
      resources :posts  do
        post '/add_tag', to: 'posts#add_tag'
        delete '/remove_tag/:id', to: 'posts#remove_tag'
      end
    end
  end
end
