# require 'byebug'
Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  post '/users/:id/follow', to: "users#follow"
  post '/users/:id/unfollow', to: "users#unfollow"
  post "/users/followers", to: "users#followers", as: "followers"
  post "/users/following", to: "users#following", as: "following"
  resource :users do
    # byebug
    resources :posts, :comments, :likes
  end
end
