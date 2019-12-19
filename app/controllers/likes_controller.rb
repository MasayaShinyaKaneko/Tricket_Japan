class LikesController < ApplicationController

  def create
      post = Post.find(params[:post_id])
      if Like.where(user_id: current_user.id, post_id: post.id).exists?
        head :no_content
      else
        like = current_user.likes.new(post_id: post.id)
        like.save
        @count = post.likes.count
      end
  end
  def destroy
      post = Post.find(params[:post_id])
      like = current_user.likes.find_by(post_id: post.id)
      if like.present?
        like.destroy
      end
      @count = post.likes.count
  end
end
