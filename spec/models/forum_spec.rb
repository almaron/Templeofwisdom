require 'spec_helper'

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


  end
end
