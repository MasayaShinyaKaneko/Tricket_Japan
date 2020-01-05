class RoomsController < ApplicationController

	before_action :authenticate_user!

	def index
			@rooms = Room.new_message(current_user)
	end
	def show
	    @room = Room.find(params[:id])
	    if RoomUser.where(user_id: current_user.id, room_id: @room.id).present?
		    @messages = @room.messages.includes(:user)
		    @message = Message.new
		    @roomusers = @room.room_users
		    messages = @room.messages.where.not(user_id: current_user.id).where(status_open: 0)
				messages.update(status_open: 1)
	    else
	    	redirect_to posts_top_path
	    end
	end
	def create
	    @room = Room.create
	    RoomUser.create(:room_id => @room.id, :user_id => current_user.id)
	    RoomUser.create(room_user_params.merge(:room_id => @room.id))
	    redirect_to room_path(@room.id)
	end
	def status_open
			room = Room.find(params[:room_id])
			messages = room.messages.where.not(user_id: current_user.id).where(status_open: 0)
			messages.update(status_open: 1)
	end
	private
    def room_user_params
    	params.require(:room_user).permit(:user_id)
    end
end
