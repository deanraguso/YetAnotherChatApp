class MessagesController < ApplicationController
  MAX_MESSAGES = 22

  def index
    @message = Message.new
    @messages = Message.last(MAX_MESSAGES)
  end

  def create
    message = Message.create!(message_params)
    AppendMessageJob.perform_now(message, MAX_MESSAGES)
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
