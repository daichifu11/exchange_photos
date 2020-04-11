class AddRoomIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :room_id, :integer, after: :visited_id
  end
end