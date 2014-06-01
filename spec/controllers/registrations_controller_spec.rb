require "spec_helper"

describe RegistrationsController do

  describe "POST create" do

    before :each do
      @user_hash = attributes_for :user
    end

    it "should create a user" do
      expect{post :create, {user: @user_hash}}.to change{User.count}.by(1)
    end

    it "should not create an invalid user" do
      @user_hash.extract! :email
      expect{post :create, user: @user_hash}.not_to change{User.count}
    end

    describe "creating a user from oauth hash" do
      before :each do
        session[:provider] = {provider:"twitter", uid:"234232"}
      end

      it "should create an authentication" do
        expect{post :create, user: @user_hash}.to change{Authentication.count}.by(1)
      end

      it "should add an authentication to the created user" do
        post :create, user: @user_hash
        expect(Authentication.last.user_id).to eql(User.last.id)
      end

    end

  end

end