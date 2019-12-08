class FavoritesController < ApplicationController

  def create
    user = User.find(params[:follow_id])
    following = current_user.follow(user)
    if following.save
      flash[:success] = 'Successfully favorited this user'
      redirect_to user_path(user)
    else
      flash.now[:alert] = 'error'
      redirect_to user_path(user)
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:success] = 'Successfully deleted favorite'
      redirect_to user_path(user)
    else
      flash.now[:alert] = 'error'
      redirect_to user_path(user)
    end
  end

end
