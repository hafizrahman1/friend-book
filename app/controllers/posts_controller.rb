class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]

  def index
    #current_user = User.find_by_id(params[:user_id])
    @posts = Post.all_posts(current_user)
  end

  def new
    @post = Post.new
    @tags = @post.tags.build
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      # render :new
      redirect_to :back, alert: "#{@post.errors.messages}"
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
    params.require(:post).permit(:content, :photo, :tag_ids => [], :tags_attributes => [:name])
  end
end
