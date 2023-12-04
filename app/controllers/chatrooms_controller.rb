class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.where(id: current_user)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    # Create a button that makes a POST request which creates a new chatroom.
  end
end
