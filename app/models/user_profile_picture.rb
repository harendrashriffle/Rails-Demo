class UserProfilePicture < ApplicationRecord
  belongs_to :user
  validates :profile_picture, presence: true
end
