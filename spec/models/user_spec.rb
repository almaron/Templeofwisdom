require 'spec_helper'

describe User do

  context "creating a user" do
    it "should create user and profile" do
      user = create :user
      expect(user.group).to eql "user"
      expect(user.profile).to be
    end

    it "should place user in group :admins" do
      user = build_stubbed :admin
      expect(user.is_in?(:admins)).to eql true
      expect(user.is_in?(:admins, :masters)).to eql true
      expect(user.is_in?(:users)).to eql false
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
