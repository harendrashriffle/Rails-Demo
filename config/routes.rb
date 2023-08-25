# require 'byebug'
Rails.application.routes.draw do
  resources :users do
    # byebug
    resources :posts, :comments, :likes
  end
end
