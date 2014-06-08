require 'spec_helper'

describe ForumTopic do

  before :each do
    @forum = create :forum
    @topic = @forum.topics.create head:"Some topic"
    @char = create :char
    @post_params = {id:100, char: @char, created_at:"2014-01-01 00:00"}
  end

  describe "add_post" do

    it "fires when the post gets created" do
      expect(@topic).to receive(:add_post)
      @topic.posts.create(@post_params)
    end

    it "should update topic" do
      @topic.posts.create(@post_params)
      expect(@topic.last_post_id).to eql(100)
    end

    it "should send add_post to forum" do
      expect(@forum).to receive(:add_post)
      @topic.posts.create(@post_params)
    end

  end

  describe :remove_post do

    it "fires when a post is destroyed" do
      @post = @topic.posts.create(@post_params)
      expect(@topic).to receive(:remove_post)
      @post.destroy
    end

    it "should reset the last_post_* if any more posts present" do
      @topic.posts.create(@post_params)
      @topic.posts.create(id:120, char: @char, created_at:"2014-02-02 00:00")
      @topic.posts.last.destroy
      expect(@topic.last_post_id).to eql(100)
    end

    it "should destroy the topic if no posts left" do
      @post = @topic.posts.create(@post_params)
      expect(@topic).to receive(:destroy)
      @post.destroy
    end

  end

end
