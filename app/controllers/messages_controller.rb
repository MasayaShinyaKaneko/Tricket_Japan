class MessagesController < ApplicationController

# 下記はactioncableを使用しているため、room_channelに記載してある。

	# before_action :authenticate_user!

	# def create
	#   if RoomUser.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
	# 		Room.find(params[:message][:room_id]).touch
	# 		@message = Message.create(message_params.merge(:user_id => current_user.id))
	# 		redirect_to room_path(@message.room_id)
	#   else
	#    	redirect_to user_path(current_user)
	#   end
	# end

	# private
	# 	def message_params
	# 		params.require(:message).permit(:user_id, :room_id, :content)
	# 	end
end
