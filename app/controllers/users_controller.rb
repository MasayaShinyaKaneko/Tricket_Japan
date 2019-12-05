class UsersController < ApplicationController
	def top
	end
	def about
	end
	def index_traveler
		@users = User.where(type_user: 1)
	end
	def search_traveler
		if params[:search_flag] == "1"
			@users = User.where(type_user: 1).where("name_user LIKE ?", "%#{params[:user_search]}%")
		else
		end
		render :index_traveler
	end
	def index_local

	end
	def search_local

	end
	def sort_local

	end
	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: @user.id)
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
