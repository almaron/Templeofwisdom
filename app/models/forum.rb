class Forum < ActiveRecord::Base

  has_ancestry

  has_many :topics, class_name: ForumTopic

  def add_post(post)
    self.path.update_all({
                    last_post_id: post.id,
                    last_post_topic_id: post.topic_id,
                    last_post_char_name: post.char.name,
                    last_post_at: post.created_at
                })
  end

  has_many :posts, through: :topics

  def remove_post(post)
    self.path.each { |f| f.update_last_post if post.id == f.last_post_id }
  end

  def update_last_post
    last_post = self.posts.last
    self.update({
                    last_post_id: last_post.id,
                    last_post_topic_id: last_post.topic_id,
                    last_post_char_name: last_post.char.name,
                    last_post_at: last_post.created_at
                })
  end

end
