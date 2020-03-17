class RelationshipsController < ApplicationController
  def create
    @search = User.ransack(params[:q])
    @result = @search.result(distinct: true)
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @search = User.ransack(params[:q])
    @result = @search.result(distinct: true)
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end