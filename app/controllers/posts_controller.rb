class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  before_action :set_user, only: [:index, :new]

  def index
    if @user
      @posts = @user.posts.order("created_at DESC")
    else
      redirect_to root_path, alert: "Users not found!"
    end
  end

  def new
    if @user == current_user
      @post = Post.new
    else
      redirect_to root_path, alert: "Access denied!"
    end
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user)
    else
      # render :new
      redirect_to :back, alert: "#{@post.errors.messages}"
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(current_user), alert: "Post deleted successfully!"
  end

  def feed
    @posts = Post.all_posts(current_user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :photo, :tag_ids => [], :tags_attributes => [:name])
  end
end
