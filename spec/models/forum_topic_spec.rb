require 'rails_helper'

describe ForumTopic do

  before :each do
    @forum = create :forum
    @topic = @forum.topics.create head:"Some topic"
    @char = build :char
    @post_params = {id:100, char: @char, created_at:"2014-01-01 00:00"}
  end

  describe "add_post" do

    before :each do
      @post = @topic.posts.new(@post_params)
    end

    it "should update topic" do
      @topic.add_post @post
      expect(@topic.last_post_id).to eql(100)
    end

    it "should send add_post to forum" do
      expect(@forum).to receive(:add_post)
      @topic.add_post @post
    end

    it "should increase the postscount" do
      expect{@topic.add_post @post}.to change{@topic.posts_count}.by 1
    end

  end

  describe :remove_post do

    before :all do
      @second_post_params = {id:120, char: @char, created_at:"2014-02-02 00:00"}
    end

    it "should reset the last_post_* if any more system_posts present" do
      @topic.posts.new @post_params
      @post  = ForumPost.new @second_post_params
      @topic.remove_post @post
      expect(@topic.last_post_id).to eql(100)
    end

    it "should destroy the topic if no system_posts left" do
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

    it "should decrease the posts_count" do
      @topic.posts_count = 5
      @post = @topic.posts.new @post_params
      @topic.remove_post @post
      expect(@topic.posts_count).to eql(4)
    end

  end

end
