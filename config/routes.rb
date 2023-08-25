# require 'byebug'
Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  resources :users do
    # byebug
    resources :posts, :comments, :likes
  end
end
