class UsersController < ApplicationController

	before_action :authenticate_user!, except: [:top, :complete]

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
		@most_favorited_usersId.each do |f|
			if User.find(f).type_user_before_type_cast == 1
				@most_favorited_users  << User.find(f)
				if @most_favorited_users.count == 5
					break
			    end
			end
		end
	end
	def search_local
        @nationality = NATIOALITY
        @language = LANGUAGE
        @search_flag = 0
		if params[:search_flag] == "1"
			@users = User.where(type_user: 1).where("name_user LIKE ?", "%#{params[:user_search]}%")
		elsif params[:search_flag] == "2"
			@users = User.where(type_user: 1).where(nationality: params[:nationality])
		elsif  params[:search_flag] == "3"
			@users = User.where(type_user: 1).where('language_first = ? or language_second = ? or language_third = ?', params[:language], params[:language], params[:language])
		end
		render :index_local
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
	def favorite
		@user = current_user
		@posts_like = []
		@user.likes.each do |l|
			@posts_like << l.post
		end
		@users = @user.followings
		@comments = Comment.where(user_id: @user.id)
		@posts_comment = []
		@comments.each do |c|
			@posts_comment << Post.find_by(id: c.post.id)
		end
		@posts_comment = @posts_comment.uniq
	end
	def edit
        @nationality = NATIOALITY
        @country = COUNTRY
		@language = LANGUAGE
        @user = User.find(params[:id])
		if @user != current_user
           redirect_to posts_top_path
        else
           @user = User.find(params[:id])
           render :edit
        end
	end
	def update
		@nationality = NATIOALITY
        @country = COUNTRY
		@language = LANGUAGE
	    @user = User.find(params[:id])
	    if @user.update(user_params)
	    	flash[:success] = "You have edited profile successfully."
	    	redirect_to user_path(@user)
	    else
	    	flash[:error] = "error!!"
	    	render :edit
	    end
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
	def status_flag
		current_user.update(delete_flag: 1)
		Devise.sign_out_all_scopes ? sign_out : sign_out(current_user)
		redirect_to users_unsubscribe_complete_path
	end

	private
	def user_params
		params.require(:user).permit(:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction, :picture_profile, :picture_background)
	end
end
