class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]

  def index
    @post = current_user.posts.build
    @posts = Post.all_posts(current_user)
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      # render :new
      redirect_to :back, alert: "Post content can not be blank!"
    end
  end

  def destroy
    @post.destroy
    redirect_to :back, alert: "Post deleted successfully!"
  end

  private

  def set_post
    if Post.exists?(params[:id])
      @post = Post.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:content, :photo, :tag_ids => [], :tag_attributes => [:name])
  end
end
