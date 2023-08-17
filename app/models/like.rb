class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :interest, presence: true
end
