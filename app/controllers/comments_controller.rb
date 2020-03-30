class CommentsController < ApplicationController
  def create 
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: users_path)
    else
      redirect_back(fallback_location: rooms_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:image, :message_id)
  end
end