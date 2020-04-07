class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :room
  has_many :comments
  has_many :notifications, dependent: :destroy
  validates :image, presence: true

  # -----コメント通知ロジック-----
  def create_notification_comment!(current_user, comment_id, room_id)
    # コメントしている人を取得
    temp_ids = Comment.select(:user_id).where(message_id: id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, self.user.id, room_id)
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id, room_id)
    notification = current_user.active_notifications.new(
      room_id: room_id,
      message_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    notification.save if notification.valid?
  end

  # -----メッセージ通知ロジック-----
  def create_notification_message!(current_user, room_id, message_id)
    # 自分以外にメッセージを送った人を取得(相手のメッセージを取得)
    temp_ids = Message.select(:user_id).where(room_id: room_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      temp_id.save_notification_message!(current_user, room_id, message_id, temp_id)
    end
  end

  def save_notification_message!(current_user, room_id, message_id, temp_id)
    notification = current_user.active_notifications.new(
      room_id: room_id,
      message_id: message_id,
      visited_id: temp_id.user.id,
      action: "message"
    )
    notification.save!
  end
end