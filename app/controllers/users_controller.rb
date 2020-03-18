class UsersController < ApplicationController
  def index
    @search = User.ransack(params[:q])
    @result = @search.result(distinct: true)
    @check = params[:q]
  end

  def show
  end

  def other_user_show
    @user = User.find(params[:id])
    # ----------メッセージロジック----------
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    if @user.id != current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id then
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
    # -----------------------------------
  end

  def following
    @users = current_user.following
    render "show_follow"
  end

  def followers
    @users = current_user.followers
    render "show_follow"
  end
end


