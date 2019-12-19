class Admins::UsersController < ApplicationController

	before_action :authenticate_admin!

	def index_traveler
		@users = User.where(type_user: 0).reverse
	end
	def search_traveler
		if params[:search_flag] == "1"
			if params[:delete_flag] == "0"
				@users = User.where(type_user: 0).with_deleted.where("name_first || name_last LIKE ?", "%#{params[:user_search]}%")
			elsif params[:delete_flag] == "1"
				@users = User.where(type_user: 0).where("name_first || name_last LIKE ?", "%#{params[:user_search]}%")
			elsif params[:delete_flag] == "2"
				@users = User.where(type_user: 0).only_deleted.where("name_first || name_last LIKE ?", "%#{params[:user_search]}%")
			end
		elsif params[:search_flag] == "2"
			if params[:delete_flag] == "0"
				@users = User.where(type_user: 0).with_deleted.where("name_user LIKE ?", "%#{params[:user_name_search]}%")
			elsif params[:delete_flag] == "1"
				@users = User.where(type_user: 0).where("name_user LIKE ?", "%#{params[:user_name_search]}%")
			elsif params[:delete_flag] == "2"
				@users = User.where(type_user: 0).only_deleted.where("name_user LIKE ?", "%#{params[:user_name_search]}%")
			end
		end
		render :index_traveler
	end

	def sort_traveler

	end

	def index_local
		@users = User.where(type_user: 1).reverse
	end
	def search_local
		if params[:search_flag] == "1"
			if params[:delete_flag] == "0"
				@users = User.where(type_user: 1).with_deleted.where("name_first || name_last LIKE ?", "%#{params[:user_search]}%")
			elsif params[:delete_flag] == "1"
				@users = User.where(type_user: 1).where("name_first || name_last LIKE ?", "%#{params[:user_search]}%")
			elsif params[:delete_flag] == "2"
				@users = User.where(type_user: 1).only_deleted.where("name_first || name_last LIKE ?", "%#{params[:user_search]}%")
			end
		elsif params[:search_flag] == "2"
			if params[:delete_flag] == "0"
				@users = User.where(type_user: 1).with_deleted.where("name_user LIKE ?", "%#{params[:user_name_search]}%")
			elsif params[:delete_flag] == "1"
				@users = User.where(type_user: 1).where("name_user LIKE ?", "%#{params[:user_name_search]}%")
			elsif params[:delete_flag] == "2"
				@users = User.where(type_user: 1).only_deleted.where("name_user LIKE ?", "%#{params[:user_name_search]}%")
			end
		end
		render :index_local
	end

	def sort_local

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
