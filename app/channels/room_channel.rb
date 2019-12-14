class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for "room_#{params[:room_id]}"
  end

  def unsubscribed
    # Any clkanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create(room_id: data['room_id'], user_id: current_user.id, content: data['message'])
    Room.find(data['room_id']).touch
    RoomChannel.broadcast_to "room_#{data['room_id']}", content: render_message(message),user_id: current_user.id
  end

  private
    def render_message(message)
      user = current_user
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, user: user })
    end
end
