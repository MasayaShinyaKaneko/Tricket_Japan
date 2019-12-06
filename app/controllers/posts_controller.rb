class PostsController < ApplicationController
	def top

	end
	def index

	end
	def sort

	end
	def show
        @post = Post.find(params[:id])
        @user = @post.user
	end
	def status_display

	end
	def status_accomplish

	end
	def new
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
	      params.require(:post).permit(:title, :content, :area, :season, :interest, :time_todo, :place_todo, :status_display, :post_image, :image_accomplishment)
	    end
end