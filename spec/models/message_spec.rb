require 'spec_helper'

describe Message, :type => :model do

  describe 'destruct' do

    before :each do
      @message = create :message
    end

    it 'should delete the message withought receivers' do
      expect{@message.destruct}.to change{Message.count}.by -1
    end

    it 'should not delete the message if it has receivers' do
      @message.receivers.create attributes_for(:message_receiver)
      expect{@message.destruct}.to change{Message.count}.by 0
    end

    it 'should set the attribute instead of deleting the record' do
      @message.receivers.create attributes_for(:message_receiver)
      @message.destruct
      expect(Message.find(@message.id).deleted?).to be_truthy
    end

  end

  describe :deleted? do

    it 'should return true if the message is marked as deleted' do
      @message = Message.new(deleted:1)
      expect(@message.deleted?).to be_truthy
    end

  end

end
