class UsersController < ApplicationController

	before_action :authenticate_user!, except: [:top, :complete]

	def index_traveler
      @nationality = NATIOALITY
      @language = LANGUAGE
			@users = User.travelers
	end
	def search_traveler
      @nationality = NATIOALITY
     	@language = LANGUAGE
			if params[:search_flag] == "1"
				@users = User.travelers.where("name_user LIKE ?", "%#{params[:user_search]}%")
			elsif params[:search_flag] == "2"
				@users = User.travelers.where(nationality: params[:nationality])
			elsif  params[:search_flag] == "3"
				@users = User.travelers.where('language_first = ? or language_second = ? or language_third = ?', params[:language], params[:language], params[:language])
			end
			render :index_traveler
	end
	def index_local
      @nationality = NATIOALITY
      @language = LANGUAGE
			@users = User.locals
			@most_favorited_usersId = Favorite.most_favorited_userId
			@most_favorited_users = []
			@most_favorited_usersId.each do |f|
				unless User.find_by(id: f).nil? #gem"paranoia"用
					if User.find(f).type_user_before_type_cast == 1
						@most_favorited_users  << User.find(f)
						if @most_favorited_users.count == 5 #ranking5位まで
							break
					    end
					end
				end
			end
	end
	def search_local
      @nationality = NATIOALITY
      @language = LANGUAGE
      @search_flag = 0
			if params[:search_flag] == "1"
				@users = User.locals.where("name_user LIKE ?", "%#{params[:user_search]}%")
			elsif params[:search_flag] == "2"
				@users = User.locals.where(nationality: params[:nationality])
			elsif  params[:search_flag] == "3"
				@users = User.locals.where('language_first = ? or language_second = ? or language_third = ?', params[:language], params[:language], params[:language])
			end
			render :index_local
	end
	def show
			@user = User.find(params[:id])
			@posts_unaccomplish = Post.where(user_id: @user.id, status_accomplishment: 0)
			@posts_accomplish = Post.where(user_id: @user.id, status_accomplishment: 1)
			@favorite_count = @user.followers.count
			# 下記messageのroom
	    @currentroomuser=RoomUser.where(user_id: current_user.id)
    	@roomuser=RoomUser.where(user_id: @user.id)
    	if @user.id != current_user.id
				@currentroomuser.each do |cu|
					@roomuser.each do |u|
					if cu.room_id == u.room_id
						@isRoom = true
						@roomId = cu.room_id
					end
				end
			end
		    if @isRoom
		    else
		        @room = Room.new
		        @roomusernew = RoomUser.new
		    end
	    end
	end
	def favorite
			@user = current_user
			@posts_like = @user.likes.map(&:post)
			@users = @user.followings
			@comments = Comment.where(user_id: @user.id)
			@post_comments = @comments.map{|c| Post.find_by(id: c.post.id)}.uniq
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
	def destroy
			current_user.destroy
			Devise.sign_out_all_scopes ? sign_out : sign_out(current_user)
			redirect_to users_unsubscribe_complete_path
	end

	private
		def user_params
				params.require(:user).permit(:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction, :picture_profile, :picture_background)
		end
end
