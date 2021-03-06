class PostsController < ApplicationController

	before_action :authenticate_user!, except: [:show]

	def top
		  @area = AREA
		  @season = SEASON
		  @interest = INTEREST
      @nationality = NATIOALITY
      @language = LANGUAGE
		  @users = User.where(type_user: 0)
		  @posts = Post.open.all
      @most_liked_posts = Post.find(Like.most_liked_postId)
		  @most_liked_posts_two = []
		  @most_liked_posts.each do |p|
        unless Post.find_by(id: p).nil? #gem"paranoia"用
    			post = Post.find(p.id)
    			if post.status_display_before_type_cast == 0
    				@most_liked_posts_two << post
    				if @most_liked_posts_two.count == 2 #ranking2位まで
    					break
    				end
    			end
        end
  		end
	end
	def index
  		@area = AREA
  		@season = SEASON
  		@interest = INTEREST
  		@posts = Post.open.all
	end
	def sort
  		@area = AREA
  		@season = SEASON
  		@interest = INTEREST
  		if params[:search_flag] == "1"
  			@posts = Post.open.where(area: params[:area])
  		elsif params[:search_flag] == "2"
  			@posts = Post.open.where(season: params[:season])
  		elsif  params[:search_flag] == "3"
  			@posts = Post.open.where(interest: params[:interest])
  		elsif  params[:search_flag] == "4"
  			@posts = Post.open.where(status_accomplishment: params[:status])
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
	end
	def update_accomplish
      @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:accomplish] = "You have posted accomplishment successfully."
        @post.update(status_accomplishment: 1)
        @post.create_notification_accomplish!(current_user)
        redirect_to post_path(@post.id)
      else
        flash[:error] = "error!!"
        redirect_to post_path(@post.id)
      end
	end
	def reset_accomplish
      @post = Post.find(params[:id])
      if @post.update(status_accomplishment: 0, image_accomplishment: nil, comment_accomplishment: nil, address: nil)
        flash[:accomplish] = "You have reset accomplishment successfully."
        redirect_to post_path(@post.id)
      else
        flash[:error] = "error!!"
        redirect_to post_path(@post.id)
      end
	end
	def new
  		@area = AREA
  		@season = SEASON
  		@interest = INTEREST
  		@post = Post.new
	end
	def create
  		@post = Post.new(post_params)
  		@area = AREA
  		@season = SEASON
  		@interest = INTEREST
    	@post.user_id = current_user.id
    	if  @post.save
    		flash[:success] = "You have posted the Tricket successfully."
    		redirect_to post_path(@post)
      else
      	flash[:error] = "error!!"
      	render :new
      end
	end
	def edit
  		@area = AREA
  		@season = SEASON
  		@interest = INTEREST
      @post = Post.find(params[:id])
		  if @post.user != current_user
        redirect_to posts_top_path
      else
      	@post = Post.find(params[:id])
      	render :edit
      end
	end
	def update
      @post = Post.find(params[:id])
  		@area = AREA
  		@season = SEASON
  		@interest = INTEREST
      if @post.update(post_params)
        flash[:success] = "You have edited the Tricket successfully."
        redirect_to post_path(@post.id)
      else
        flash[:error] = "error!!"
        render :edit
      end
	end
	def destroy
      post = Post.find(params[:id])
      post.destroy
      redirect_to user_path(current_user)
	end
  def index_photo
      @posts = Post.open.all
  end

	private
    def post_params
      params.require(:post).permit(:title, :content, :area, :season, :interest, :time_todo, :place_todo, :status_display, :post_image, :image_accomplishment, :comment_accomplishment, :address)
    end
end
