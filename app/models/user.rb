class User < ApplicationRecord
  has_many :posts
  has_many :follows
  has_one :user_profile_picture
end
