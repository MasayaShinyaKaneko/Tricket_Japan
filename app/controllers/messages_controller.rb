class MessagesController < ApplicationController

	before_action :authenticate_user!

	def create
	    if RoomUser.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
	    	Room.find(params[:message][:room_id]).touch
		    @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
		    redirect_to room_path(@message.room_id)
	    else
	    	redirect_to user_path(current_user)
	    end
	end

end