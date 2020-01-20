class UsersController < ApplicationController
  def index
    @search = User.ransack(params[:q])
    @result = @search.result(distinct: true)
    @check = params[:q]
  end

  def show
  end
end
