class UsersController < ApplicationController

	before_action :authenticate_user!, except: [:top, :about]

	def top
	end
	def about
	end
	def index_traveler
		@users = User.where(type_user: 0)
	end
	def search_traveler
		if params[:search_flag] == "1"
			@users = User.where(type_user: 0).where("name_user LIKE ?", "%#{params[:user_search]}%")
		else
		end
		render :index_traveler
	end
	def index_local
		@users = User.where(type_user: 1)
	end
	def search_local
		if params[:search_flag] == "1"
			@users = User.where(type_user: 1).where("name_user LIKE ?", "%#{params[:user_search]}%")
		else
		end
		render :index_local
	end
	def sort_local

	end
	def show
		@user = User.find(params[:id])  #view
		@posts = Post.where(user_id: @user.id)  #view
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
		@user = User.find(params[:id])
	end
	def status_user

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
