class PostsController < ApplicationController

	before_action :authenticate_user!, except: [:show]

	def top
		@area = AREA
		@season = SEASON
		@interest = INTEREST
        @nationality = NATIOALITY
        @language = LANGUAGE
		@users = User.where(type_user: 0)
		@posts = Post.all
        @most_liked_posts = Post.find(Like.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).group(:post_id).order('count(post_id) desc').limit(2).pluck(:post_id))
	end
	def index
		@area = AREA
		@season = SEASON
		@interest = INTEREST
		@posts = Post.all
	end
	def sort
		@area = AREA
		@season = SEASON
		@interest = INTEREST
		if params[:search_flag] == "1"
			@posts = Post.where(area: params[:area])
		elsif params[:search_flag] == "2"
			@posts = Post.where(season: params[:season])
		elsif  params[:search_flag] == "3"
			@posts = Post.where(interest: params[:interest])
		elsif  params[:search_flag] == "4"
			@posts = Post.where(status_accomplishment: params[:status])
		end
		render :index
	end
	def show
        @post = Post.find(params[:id])
        @user = @post.user
        @count = @post.likes.count
        @favorite_count = @user.followers.count
		@comment = Comment.new
        if current_user
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
	end
	def update_accomplish
        @post = Post.find(params[:id])
        if @post.update(post_params)
           flash[:notice] = "You have posted accomplishment successfully."
           @post.update(status_accomplishment: 1)
           redirect_to post_path(@post.id)
        else
           flash[:notice] = "error!!"
           redirect_to post_path(@post.id)
        end
	end
	def reset_accomplish
        @post = Post.find(params[:id])
        if @post.update(status_accomplishment: 0, image_accomplishment: "", comment_accomplishment: "")
           flash[:notice] = "You have reset accomplishment successfully."
           redirect_to post_path(@post.id)
        else
           flash[:notice] = "error!!"
           redirect_to post_path(@post.id)
        end
	end

	def status_display

	end
	def status_accomplish

	end
	def new
		@area = AREA
		@season = SEASON
		@interest = INTEREST
		@post = Post.new
	end
	def create
		@post = Post.new(post_params)
    	@post.user_id = current_user.id
    	if  @post.save
        	flash[:notice] = "You have creatad Tricket successfully."
    		redirect_to post_path(@post)
        else
        	flash[:notice] = "error!!"
			@post = Post.new
        	render :new
        end
	end
	def edit
		@area = AREA
		@season = SEASON
		@interest = INTEREST
        @post = Post.find(params[:id])
		if  @post.user != current_user
        	flash[:notice] = "I have no authorization to edit"
        	redirect_to posts_top_path
        else
        	@post = Post.find(params[:id])
        	render :edit
        end
	end
	def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
           flash[:notice] = "You have updated Tricket successfully."
           redirect_to post_path(@post.id)
        else
           flash[:notice] = "error!!"
           render :edit
        end
	end
	def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to user_path(current_user)
	end

	private
	    def post_params
	      params.require(:post).permit(:title, :content, :area, :season, :interest, :time_todo, :place_todo, :status_display, :post_image, :image_accomplishment, :comment_accomplishment)
	    end
end
