class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :user_profile_picture, dependent: :destroy

  validates :name, length: {minimum: 4}, presence: true
  validates :email, uniqueness: { downcase: true }
end
