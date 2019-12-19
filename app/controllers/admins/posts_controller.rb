class Admins::PostsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@posts = Post.with_deleted.reverse
	end
	def search
		if params[:search_flag] == "1"
			@posts = Post.where("created_at LIKE ?", "%#{params[:date_search]}%")
		elsif params[:search_flag] == "2"
			@posts = Post.where("title LIKE ?", "%#{params[:title_search]}%")
		elsif params[:search_flag] == "3"
			if params[:delete_flag] == "0"
				@posts = Post.with_deleted.joins(:user).where("name_user LIKE ?", "%#{params[:user_search]}%")
			elsif params[:delete_flag] == "1"
				@posts = Post.joins(:user).where("name_user LIKE ?", "%#{params[:user_search]}%")
			elsif params[:delete_flag] == "2"
				@posts = Post.only_deleted.joins(:user).where("name_user LIKE ?", "%#{params[:user_search]}%")
			end
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
