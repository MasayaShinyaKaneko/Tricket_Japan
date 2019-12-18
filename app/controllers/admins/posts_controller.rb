class Admins::PostsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@posts = Post.all.reverse
	end
	def search
		if params[:search_flag] == "1"
			@posts = Post.where("created_at LIKE ?", "%#{params[:date_search]}%")
		elsif params[:search_flag] == "2"
			@posts = Post.joins(:user).where("name_user LIKE ?", "%#{params[:user_search]}%")
		elsif params[:search_flag] == "3"
			@posts = Post.where("title LIKE ?", "%#{params[:title_search]}%")
		end
		render :index
	end
	def sort

	end
	def show

	end
	def status_flag

	end
	def edit

	end
	def update

	end
end
