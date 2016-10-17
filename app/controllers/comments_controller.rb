class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :destroy]
  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.create(comment_params)

    if @comment.save
      redirect_to :back, notice: "Comment successfully created"
    else
      render action: :new
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
