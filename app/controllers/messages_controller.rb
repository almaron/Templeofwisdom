class MessagesController < ApplicationController

  before_action :require_login

  def index
    @messages = current_user.message_receivers
  end

  def outbox
    @messages = current_user.messages.where(deleted:0)
  end

  def show
    @message = Message.find(params[:id])
    current_user.message_receivers.where(message_id:params[:id]).update_all(read:1)
  end

  def new
    @message = Message.new
  end

  def reply
    @message = Message.reply params[:id]
  end

  def create
    @message = current_user.messages.create message_params
    redirect_to messages_path
  end


  def destroy
    if params[:receiver_id]
      MessageReceiver.find(params[:receiver_id]).destroy
    else
      Message.find(params[:id]).destroy
    end
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:head, :text, :char_id, :char_ids)
  end

end
