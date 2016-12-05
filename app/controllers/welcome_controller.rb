class WelcomeController < ApplicationController
	def home
	  @post = current_user.posts.build
    @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC') 
	end
end
