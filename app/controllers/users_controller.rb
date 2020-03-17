class UsersController < ApplicationController
  def index
    @search = User.ransack(params[:q])
    @result = @search.result(distinct: true)
    @check = params[:q]
  end

  def show
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
