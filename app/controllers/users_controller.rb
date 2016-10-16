class UsersController < ApplicationController
  def index
    @users = User.all.order(:id)
    @post = current_user.posts.build
  end
end
