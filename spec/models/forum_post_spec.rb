require 'rails_helper'

describe ForumPost do
  describe "after create" do

    it "should trigger a topic touch" do
      @forum = create :forum
      @topic = @forum.topics.create head:"Some Topic"
      @char = create :char
      @post = @topic.posts.build attributes_for(:forum_post).merge!({char_id:@char.id})
      expect(@post.topic).to receive(:add_post).with(@post)
      @post.save
    end

  end
end
