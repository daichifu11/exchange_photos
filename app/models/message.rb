class Message < ApplicationRecord
  mount_uploader :image, AvatarImagesUploader
  belongs_to :user
  belongs_to :room
  has_many :comments
  has_many :notifications, dependent: :destroy

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し
    temp_ids = Comment.select(:user_id).where(message_id: id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, self.user.id)
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      message_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    notification.save if notification.valid?
  end
end
