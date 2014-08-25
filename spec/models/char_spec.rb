require 'rails_helper'

RSpec.describe Char, :type => :model do

  context 'basic setup' do
    before do
      @char = create :char
    end

    it 'has profile' do
      expect(@char.profile).to be_a(CharProfile)
    end
  end


  context 'delegate_to and undelegate' do
    it 'delegates and undelegates' do
      user = create :user
      char = build_stubbed :char
      expect{ char.delegate_to user}.to change{char.users.size}.by(1)
      expect{ char.undelegate user}.to change{char.users.size}.by(-1)
    end

    it 'makes the user an owner' do
      user = create :user
      char = create :char
      expect{ char.delegate_to user, owner:1}.to change{char.char_delegations.where(owner:1).size}.by(1)
    end
  end

  context 'admin methods' do

    before :each do
      @char = create :char
      @user = User.create(name:'Malk', current_ip:'127.0.01', email:'poo@foo.com')
      @forum = Forum.create(name:'AdminChars')
      @char.delegate_to @user, owner:1
      AdminConfig.create name: 'char_profile_forum_id_3', value: @forum.id.to_s
      AdminConfig.create name: 'accept_master_id', value: @char.id.to_s
      AdminConfig.create name: 'approve_master_id', value: @char.id.to_s
      CharGroup.create(id:3, name:'look')
    end

    describe :accept do

      it "should change the status_id to 3" do
        @char.accept @user
        expect(@char.status_id).to eql 3
      end

      it "should not accept char if it's not pending" do
        @char.status_id = 5
        expect(@char.accept(@user)).to be_falsey
      end

      it "should create a topic with the chars profile" do
        expect(ForumTopic).to receive(:create)
        @char.accept @user
      end

      it "should send an email"

      it 'should send a notification' do
        expect(Notification).to receive(:create)
        @char.accept @user
      end

    end

    context :approve do

      before :each do
        @char.status_id = 3
        @topic = @forum.topics.create(head:'Approve Topic')
        @char.profile_topic_id = @topic.id
      end

      it "should change the status_id to 5" do
        @char.approve @user
        expect(@char.status_id).to eql 5
      end

      it 'should not change the char if it\'s not on review' do
        @char.status_id = 2
        expect(@char.approve @user).to be_falsey
      end

      it 'should add a final post to the topic' do
        expect(ForumPost).to receive(:create)
        @char.approve @user
      end

      it 'should send an email'

      it 'should send a notification' do
        expect(Notification).to receive(:create)
        @char.approve @user
      end

    end

    context :decline do

      it "should remove the char" do
        expect(@char).to receive(:destroy)
        @char.decline
      end

      it 'should not decline a char that is not pending' do
        @char.status_id = 5
        expect(@char.decline).to be_falsey
      end

      it 'should send an email'

      it 'should send a notification' do
        expect(Notification).to receive(:create)
        @char.decline
      end

    end

  end

  context "add and remove points" do

    before do
      @char = create :char
    end

    it 'increases the char\'s points by the value' do
      expect{@char.add_points(30)}.to change{@char.profile.points}.by(30)
    end

    it 'decreases the char\'s points by the value' do
      expect{@char.remove_points(30)}.to change{@char.profile.points}.by(-30)
    end

    it "calculates if the char has enough points" do
      @char.add_points 400
      expect(@char.has_enough_points? 400).to eq true
      expect(@char.has_enough_points? 600).to eq false
    end

  end

end
