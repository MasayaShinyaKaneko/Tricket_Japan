class Admins::PostsController < ApplicationController

	before_action :authenticate_admin!

	def index
			@posts = Post.only_post_deleted_not_user.reverse #paranoia用
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
			if params[:sort_flag] == "1"
				@posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
				render :index
			else params[:sort_flag] == "2"
				@posts = Post.find(Like.group(:post_id).order('count(post_id) asc').pluck(:post_id))
				render :index
			end
	end
	def show
			@post = Post.with_deleted.find(params[:id])
			@user = @post.user
	end
	def destroy
      post = Post.find(params[:id])
      post.destroy
	end
	def restore
      post = Post.only_deleted.find(params[:id])
      post.restore
	end
	def comment_destroy
		  comment = Comment.find(params[:id])
      @post = Post.with_deleted.joins(:comments).where("comments.id = ?", comment.id).first
      comment.destroy
      redirect_to admins_user_path(comment.user)
	end
end
