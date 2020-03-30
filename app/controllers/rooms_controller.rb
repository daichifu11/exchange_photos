class RoomsController < ApplicationController
  
  def index
    @entries = Entry.where(user_id: current_user.id)
  end
# ----------メッセージロジック----------
  def create
    # @user = User.find(params[:id]) 要らないかも
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    # @comments = @messages.comments 要らないかも
    @comment = Comment.new
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entryies = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
# ------------------------------------

  private
  
  def comment_params
    params.require(:comment).permit(:image)
  end
end
