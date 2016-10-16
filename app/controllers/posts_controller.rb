class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]

  def index
    @post = current_user.posts.build
    @all_posts = (Post.where(user: current_user) + Post.where(user: current_user.friends)).order(:created_at)
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to :back
    else
      render :new
    end
  end

  def destroy
    @post.destroy

    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
