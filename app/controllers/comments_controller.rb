class CommentsController < ApplicationController
	def create
		comment = Comment.new(comment_params)
       	@post = Post.find(params[:post_id])
    	comment.user_id = current_user.id
    	comment.post_id = @post.id
    	if  comment.save
        	@post.create_notification_comment!(current_user, comment.id)
    		redirect_to post_path(@post)
        else
        	redirect_to post_path(@post)
        end
	end
	def edit
		@comment = Comment.find(params[:id])
	end
	def update
        @comment = Comment.find(params[:id])
        @comment.update(comment_params)
	end
	def destroy
		comment = Comment.find(params[:id])
        comment.destroy
        redirect_to post_path(comment.post)
	end
	private
	    def comment_params
	      params.require(:comment).permit(:user_id, :post_id, :content)
	    end
end
