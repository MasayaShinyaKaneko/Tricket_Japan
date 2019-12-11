class UsersController < ApplicationController

	before_action :authenticate_user!, except: [:top, :about]

	def top
	end
	def index_traveler
        @nationality = NATIOALITY
        @language = LANGUAGE
		@users = User.where(type_user: 0)
	end
	def search_traveler
        @nationality = NATIOALITY
        @language = LANGUAGE
		if params[:search_flag] == "1"
			@users = User.where(type_user: 0).where("name_user LIKE ?", "%#{params[:user_search]}%")
		elsif params[:search_flag] == "2"
			@users = User.where(type_user: 0).where(nationality: params[:nationality])
		elsif  params[:search_flag] == "3"
			@users = User.where(type_user: 0).where('language_first = ? or language_second = ? or language_third = ?', params[:language], params[:language], params[:language])
		end
		render :index_traveler
	end
	def index_local
        @nationality = NATIOALITY
        @language = LANGUAGE
		@users = User.where(type_user: 1)
		@most_favorited_usersId = Favorite.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).group(:follow_id).order('count(follow_id) desc').pluck(:follow_id)
		@most_favorited_users = []
		@most_favorited_usersId.each do |i|
			if User.find(i).type_user == 1
				@most_favorited_users  << User.find(i)
				if @most_favorited_users.count == 2
					break
			    end
			end
		end
	end
	def search_local
        @nationality = NATIOALITY
        @language = LANGUAGE
		if params[:search_flag] == "1"
			@users = User.where(type_user: 1).where("name_user LIKE ?", "%#{params[:user_search]}%")
		elsif params[:search_flag] == "2"
			@users = User.where(type_user: 1).where(nationality: params[:nationality])
		elsif  params[:search_flag] == "3"
			@users = User.where(type_user: 1).where('language_first = ? or language_second = ? or language_third = ?', params[:language], params[:language], params[:language])
		end
		render :index_local
	end
	def sort_local

	end
	def show
		@user = User.find(params[:id])  #view
		@posts_unaccomplish = Post.where(user_id: @user.id, status_accomplishment: 0)  #view
		@posts_accomplish = Post.where(user_id: @user.id, status_accomplishment: 1)  #view
		@favorite_count = @user.followers.count
		# 下記message
	    @currentroomuser=RoomUser.where(user_id: current_user.id)
    	@roomuser=RoomUser.where(user_id: @user.id)
    	if @user.id == current_user.id
    	else
			@currentroomuser.each do |cu|
			@roomuser.each do |u|
				if cu.room_id == u.room_id
					@isRoom = true  #view
					@roomId = cu.room_id  #view
				else
				end
			end
			end
		    if @isRoom
		    else
		        @room = Room.new  #view
		        @roomusernew = RoomUser.new  #view
		    end
	    end
	end
	def edit
        @nationality = NATIOALITY
        @country = COUNTRY
		@language = LANGUAGE

        @user = User.find(params[:id])
		if @user != current_user
           flash[:notice] = "I have no authorization to edit"
           redirect_to posts_top_path
        else
           @user = User.find(params[:id])
           render :edit
        end
	end
	def update
	    @user = User.find(params[:id])
	    @user.update(user_params)
	    redirect_to user_path(@user.id)
	end

	def favorite
		@user = current_user
		@posts = []
		@user.likes.each do |l|
			@posts << l.post
		end
		@users = @user.followings
	end
	def status_user
		@user = User.find(params[:id])
		if @user.status_user_before_type_cast == 0
			@user.update(status_user: 1)
    	elsif @user.status_user_before_type_cast == 1
			@user.update(status_user: 2)
    	elsif @user.status_user_before_type_cast == 2
   			@user.update(status_user: 0)
   		end
	end
	def unsubscribe

	end
	def status_flag

	end
	def complete

	end

	private
	def user_params
		params.require(:user).permit(:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction, :picture_profile, :picture_background)
	end
end
