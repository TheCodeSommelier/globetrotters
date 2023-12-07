class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    receiver_id = @chatroom.user_1_id == current_user.id ? @chatroom.user_2_id : @chatroom.user_1_id
    if @message.save
      ActionCable.server.broadcast("chatroom:#{@chatroom.id}:#{receiver_id}", {
        html: render_to_string(partial: "message", locals: { message: @message, user: User.find(receiver_id) }),
        user_id: current_user.id,
      })
      ActionCable.server.broadcast("chatroom:#{@chatroom.id}:#{current_user.id}", {
        html: render_to_string(partial: "message", locals: { message: @message, user: current_user }),
        user_id: current_user.id,
      })
      head :ok
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
