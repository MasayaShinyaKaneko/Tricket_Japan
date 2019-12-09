class FavoritesController < ApplicationController

  def create
    user = User.find(params[:follow_id])
    if Favorite.where(user_id: current_user.id, follow_id: user.id).exists?
        head :no_content
    else
        following = current_user.follow(user)
        @favorite_count = user.followers.count
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    @favorite_count = user.followers.count
  end
end
