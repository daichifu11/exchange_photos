class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :message
  has_many :notifications, dependent: :destroy
  validates :image, presence: true
end
