class MessagesController < ApplicationController
  def index
    @message = Message.new
    @messages = Message.limit(10).order(:created_at)
  end

  def create
    message = Message.create!(message_params)
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
