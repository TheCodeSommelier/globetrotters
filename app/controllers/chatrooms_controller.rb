class ChatroomsController < ApplicationController
  def index
    chatrooms1 = Chatroom.where(user_1_id: current_user)
    chatrooms2 = Chatroom.where(user_2_id: current_user)
    @chatrooms = chatrooms1 + chatrooms2
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    user_2 = User.find_by(username: params[:user_2])
    chatroom = Chatroom.new(user_1: current_user, user_2: user_2)
    if chatroom.save!
      redirect_to chatroom_path(chatroom)
    else
      render 'profile_page', status: :unprocessable_entity
    end
  end
end
