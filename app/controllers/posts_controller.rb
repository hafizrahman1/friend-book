class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]
  before_action :set_user, only: [:new, :index]

  def index
    if @user
      @posts = @user.posts
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @posts, adapter: :json }
      end
    else
      redirect_to root_path, alert: "Users not found!"
    end
  end

  def new
    if @user == current_user
      @post = Post.new
    else
      redirect_to user_path(current_user), alert: "Access denied!"
    end
  end

  def show
    if params[:user_id]
      # @user = User.find_by(id: params[:user_id])
      # @post = @user.posts.find_by(id: params[:id])
      # if @post.nil?
      #   redirect_to user_posts_path(@user), alert: "Post not found"
      # end
    # else
      @post = Post.find(params[:id])
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @post, adapter: :json }
      end
    end
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render json: @post, adapter: :json
      # respond_to do |format|
      #   format.html { redirect_to user_posts_path(current_user) }
      #   format.json { render json: @post, adapter: :json }
      # end
    else
      # render :new
      redirect_to :back, alert: "#{@post.errors.messages}"
    end
  end

  def destroy
    @post.destroy
    # redirect_to user_posts_path(current_user), alert: "Post deleted successfully!"
    render json: @post, adapter: :json, alert: "Post deleted successfully!"
  end

  def feed
    @posts = Post.all_posts(current_user)
    respond_to do |format|
      format.html { render :feed }
      format.json { render json: @posts, adapter: :json }
    end
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
