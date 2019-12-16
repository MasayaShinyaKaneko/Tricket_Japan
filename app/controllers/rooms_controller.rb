class RoomsController < ApplicationController

	before_action :authenticate_user!

	def index
		@rooms = Room.order("updated_at desc").joins(:room_users).where("room_users.user_id = ?", current_user.id).distinct
	end

	def show
	    @room = Room.find(params[:id])
	    if RoomUser.where(user_id: current_user.id, room_id: @room.id).present?
		    @messages = @room.messages.includes(:user)
		    @message = Message.new
		    @roomusers = @room.room_users
	    else
	    	redirect_to user_path(current_user)
	    end
	end

	def create
	    @room = Room.create
	    RoomUser.create(:room_id => @room.id, :user_id => current_user.id)
	    RoomUser.create(room_user_params.merge(:room_id => @room.id))
	    redirect_to room_path(@room.id)
	end

	private
	    def room_user_params
	    	params.require(:room_user).permit(:user_id, :room_id)
	    end
end
