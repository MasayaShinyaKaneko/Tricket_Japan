class UsersController < ApplicationController
	def top
	end
	def about
	end
	def index_traveler

	end
	def search_traveler

	end
	def index_local

	end
	def search_local

	end
	def sort_local

	end
	def show

	end
	def edit
        @user = User.find(params[:id])
		if @user != current_user
           flash[:notice] = "編集するが権限がありません"
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
		params.require(:user).permit(:type_user, :name_first, :name_last, :name_user, :gender, :birthday, :nationality, :country, :language_first, :language_second, :language_third, :hobby, :introduction)
	end
end
