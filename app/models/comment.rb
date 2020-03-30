class Comment < ApplicationRecord
  mount_uploader :image, AvatarImagesUploader
  belongs_to :user
  belongs_to :message
end
