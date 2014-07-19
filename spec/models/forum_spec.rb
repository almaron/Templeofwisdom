require 'rails_helper'

describe Forum do

  describe :add_post do

    before :each do
      @parent = create :forum
      @forum = Forum.create(name:"Child", parent:@parent)
      @char = build :char
      @post = ForumPost.new(id:100, char: @char, created_at:"2014-01-01 00:00", topic_id:1)
    end

    it "should change the forum itself" do
      @forum.add_post(@post)
      @forum = Forum.find(@forum.id)
      expect(@forum.last_post_char_name).to eql(@char.name)
      expect(@forum.last_post_id).to eql(100)
      expect(@forum.last_post_at).to eql(@post.created_at)
      expect(@forum.last_post_topic_id).to eql(1)
    end


    it "should change the parent as well" do
      @forum.add_post(@post)
      @forum = Forum.find(@parent.id)
      expect(@forum.last_post_char_name).to eql(@char.name)
      expect(@forum.last_post_id).to eql(100)
      expect(@forum.last_post_at).to eql(@post.created_at)
      expect(@forum.last_post_topic_id).to eql(1)
    end

    it "should increate the posts_count" do
      @forum.add_post @post
      @forum.reload
      expect(@forum.posts_count).to eql(1)
    end

  end

  describe :remove_post do
    before :each do
      @forum = create :forum
      @forum.update(posts_count: 5)
    end

    it 'should decrease the forums posts_count' do
      @forum.remove_post ForumPost.new
      @forum.reload
      expect(@forum.posts_count).to eql(4)
    end
  end

  describe :add_topic do

    before :each do
      @forum = create :forum
    end

    it "should increase topics_count" do
      @forum.add_topic
      @forum.reload
      expect(@forum.topics_count).to eql(1)
    end

    it "should increase the parents' topics_count" do
      second_forum = @forum.children.create(name:"Second")
      second_forum.add_topic
      @forum.reload
      expect(@forum.topics_count).to eql(1)
    end

  end

  describe :remove_topic do
    before :each do
      @forum = create :forum
      @forum.update topics_count: 5
    end

    it "should decrease the topics_count" do
       @forum.remove_topic
       @forum.reload
       expect(@forum.topics_count).to eql(4)
    end

    it "should decrease the parents' topics_count" do
      second_forum = @forum.children.create(name:"Second line")
      second_forum.remove_topic
      @forum.reload
      expect(@forum.topics_count).to eql(4)
    end
  end

end
