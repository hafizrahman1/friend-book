class UsersController < ApplicationController
  def index
    @users = User.all.order(:id)
    # @post = current_user.posts.build
  end

  def show
    # @post = current_user.posts.build
    @user = User.find_by_id(params[:id])
  end
end
