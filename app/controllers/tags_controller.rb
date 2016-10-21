class TagsController < ApplicationController
	def index
	end

	def show
		@tag = Tag.find_by_id(params[:id])
		@posts = @tag.posts

	end
end
