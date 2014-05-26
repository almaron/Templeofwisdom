require 'spec_helper'

describe GuestPost do
  describe "captcha" do

    before :all do
      @post = build :guest_post
    end

    it "shoud be set on initialize" do
      expect(@post.captcha).to be_present
      expect(@post.valid_captcha).to be_present
    end

    it "should be valid" do
      expect(@post.validate_captcha).to be_true
    end

    it "should validate with the post" do
      expect(@post).to be_valid
    end
  end

  describe "validation" do
    it "should not pass on empty post" do
      expect(GuestPost.new).not_to be_valid
    end
  end
end
