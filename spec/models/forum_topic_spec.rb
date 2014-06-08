require 'spec_helper'

describe ForumTopic do

  before :each do
    @forum = create :forum
    @topic = @forum.topics.create head:"Some topic"
    @char = build :char
    @post_params = {id:100, char: @char, created_at:"2014-01-01 00:00"}
  end

  describe "add_post" do

    it "should update topic" do
      @post = @topic.posts.new(@post_params)
      @topic.add_post @post
      expect(@topic.last_post_id).to eql(100)
    end

    it "should send add_post to forum" do
      @post = @topic.posts.new(@post_params)
      expect(@forum).to receive(:add_post)
      @topic.add_post @post
    end

  end

  describe :remove_post do

    before :all do
      @second_post_params = {id:120, char: @char, created_at:"2014-02-02 00:00"}
    end

    it "should reset the last_post_* if any more posts present" do
      @topic.posts.new @post_params
      @post  = ForumPost.new @second_post_params
      @topic.remove_post @post
      expect(@topic.last_post_id).to eql(100)
    end

    it "should destroy the topic if no posts left" do
      @post = ForumPost.new(@post_params)
      @post.topic_id = 5
      expect(@topic).to receive(:destroy)
      @topic.remove_post @post
    end

    it "fires the call up the stack" do
      @post = ForumPost.new(@post_params)
      @post.topic_id = 5
      expect(@forum).to receive(:remove_post).with(@post)
      @topic.remove_post @post
    end

  end

end
