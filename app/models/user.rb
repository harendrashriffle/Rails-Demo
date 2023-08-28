class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :following_users

  has_secure_password

  validates :name, length: {minimum: 4}, presence: true
  validates :email, uniqueness: {case_sensitive: false}
  validates :password_digest, length: {minimum: 4}
end
