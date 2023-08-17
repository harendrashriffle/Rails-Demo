class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :content, presence: true
  validates :picture, presence: true

  # def check
  #   if content.nil? == false || if picture.nil? == false
  # end
end
