class Admins::UsersController < ApplicationController

	before_action :authenticate_admin!

	def index_traveler
			@users = User.where(type_user: 0).with_deleted.reverse
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
			if params[:sort_flag] == "1"
				@most_favorited_usersId = Favorite.most_favorited_userId
				@users = []
				@most_favorited_usersId.each do |f|
					unless User.find_by(id: f).nil? #gem"paranoia"用
						if User.find(f).type_user_before_type_cast == 0
							@users  << User.find(f)
						end
					end
				end
			else params[:sort_flag] == "2"
				@least_favorited_usersId = Favorite.least_favorited_userId
				@users = []
				@least_favorited_usersId.each do |f|
					unless User.find_by(id: f).nil? #gem"paranoia"用
						if User.find(f).type_user_before_type_cast == 0
							@users  << User.find(f)
						end
					end
				end
			end
			render :index_traveler
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
			if params[:sort_flag] == "1"
				@most_favorited_usersId = Favorite.most_favorited_userId
				@users = []
				@most_favorited_usersId.each do |f|
					unless User.find_by(id: f).nil? #gem"paranoia"用
						if User.find(f).type_user_before_type_cast == 1
							@users  << User.find(f)
						end
					end
				end
			else params[:sort_flag] == "2"
				@least_favorited_usersId = Favorite.least_favorited_userId
				@users = []
				@least_favorited_usersId.each do |f|
					unless User.find_by(id: f).nil? #gem"paranoia"用
						if User.find(f).type_user_before_type_cast == 1
							@users  << User.find(f)
						end
					end
				end
			end
			render :index_local
	end
	def show
			@user = User.with_deleted.find(params[:id])
			@posts = @user.posts.with_deleted
	end
	def destroy
      user = User.find(params[:id])
      user.destroy
	end
	def restore
      user = User.only_deleted.find(params[:id])
      user.restore
	end
end
