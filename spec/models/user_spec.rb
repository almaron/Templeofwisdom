require 'spec_helper'

describe User, :type => :model do

  context "creating a user" do
    it "should create user and profiles" do
      user = create :user
      expect(user.group).to eql "user"
      expect(user.profile).to be
    end

    it "should place user in group :admins" do
      user = build_stubbed :admin
      expect(user.is_in? :admin).to eql true
      expect(user.is_in? [:admin, :master]).to eql true
      expect(user.is_in? :user ).to eql false
    end
  end

  describe "is_in?" do
    before :all do
      @user = build_stubbed :admin
    end

    it "should return true if the user belongs to the group" do
      expect(@user.is_in? :admin).to eql true
    end

    it "should return false if the user does not belong to the group" do
      expect(@user.is_in? :user).to eql false
    end

    it "should return true if the user belongs to one of the groups" do
      expect(@user.is_in? [:admin, :master]).to eql true
    end

    it "should return false if the user does not belong to any of the groups" do
      expect(@user.is_in? [:user, :master]).to eql false
    end

  end

  describe "default_char" do

    context "if user does have a char" do

      before(:each) do
        @user = create :user
        @char = create :char
        @char.delegate_to @user, owner:1
        @user.default_char = @char
      end

      it "should assign a default char" do
        expect(@user.char_delegations.where(default:1,owner:1).count).to eq(1)
      end

      it "should get the default char" do
        expect(@user.default_char).to eq(@char)
      end

    end

    it "should return nil on none" do
      user = create :user
      expect(user.default_char).to be_nil
    end
  end

end
