require 'rails_helper'

describe MessageReceiver, :type => :model do

  it 'should be sent to char\'s owner' do
    user = create :user
    char = create :char
    char.delegate_to user, owner:1

    mr = MessageReceiver.create(char_id: char.id)
    expect(mr.user_id).to eql user.id
  end

  it 'should check the message after destroy' do
    @message = Message.create attributes_for(:message).merge(deleted:1)
    @receiver = @message.receivers.create attributes_for(:message_receiver)
    expect{MessageReceiver.find(@receiver.id).destroy}.to change{Message.count}.by -1
  end


end
