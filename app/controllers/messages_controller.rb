class MessagesController < ApplicationController

  before_action :require_login

  def index
    @messages = current_user.message_receivers.group(:message_id).collect do |rcv|
      mess = rcv.message
      mess.read = rcv.read
      mess
    end
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def outbox
    @messages = current_user.messages.where(deleted:0)
    respond_to do |format|
      format.html {}
      format.json { render :index }
    end
  end

  def show
    @message = Message.find(params[:id])
    current_user.message_receivers.where(message_id:params[:id]).update_all(read:1) if @message
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def new
    @message = Message.new
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def reply
    @message = Message.reply params[:id]
    respond_to do |format|
      format.html {}
      format.json { render :new}
    end
  end

  def create
    respond_to do |format|
      @message = Message.create message_params
      if @message.valid?
        format.html {}
        format.json { render :show}
      else
        format.html {}
        format.json { render json:@message.errors.full_messages, status: 500 }
      end
    end
  end


  def destroy
    if params[:receiver]=='true'
      MessageReceiver.where(message_id: params[:id]).where(user_id:current_user.id).destroy_all
    else
      @message = Message.find(params[:id])
      @message.destruct
    end
    respond_to do |format|
      format.html {}
      format.json { render json: @message}
    end
  end

  private

  def message_params
    params.require(:message).permit(:head, :text, :char_id, char_ids: []).merge(user_id: current_user.id)
  end

end
