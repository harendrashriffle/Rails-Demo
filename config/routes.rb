# require 'byebug'
Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  resource :users do
    # byebug
    resources :posts, :comments, :likes
  end
end
