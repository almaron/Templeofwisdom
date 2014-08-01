require 'spec_helper'

describe GuestPost, :type => :model do

  before :all do
    @post = build :guest_post
  end

  describe "captcha" do

    it "shoud be set on initialize" do
      expect(@post.captcha).to be_present
      expect(@post.valid_captcha).to be_present
    end

    it "should be valid" do
      expect(@post.validate_captcha).to be_truthy
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

  # describe "apply_answer" do
  #   it "should apply an answer" do
  #     @post.apply_answer "Some answer string"
  #     expect(@post.answer).to eq("Some answer string")
  #   end
  #
  #   it "autolinks urls" do
  #     @post.apply_answer "Here is a url: http://link.com"
  #     expect(@post.answer).to eq("Here is a url: <a href=\"http://link.com\" target=\"_blank\">ссылка</a>")
  #   end
  #
  #   it "autolinks mails" do
  #     @post.apply_answer "Here is a mail: alm@example.com"
  #     expect(@post.answer).to eq("Here is a url: <a href=\"mailto:alm@example.com\">'этот адрес</a>")
  #   end
  # end
end
