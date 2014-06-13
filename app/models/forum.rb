class Forum < ActiveRecord::Base

  has_ancestry

  has_many :topics, class_name: ForumTopic

  default_scope {order(:sort_order)}

  def add_post(post)
    self.path.update_all({
                    last_post_id: post.id,
                    last_post_topic_id: post.topic_id,
                    last_post_char_name: post.char.name,
                    last_post_at: post.created_at
                })
    self.path.update_all("posts_count = posts_count + 1")
  end

  def add_topic
    self_path.update_all("topics_count = topics_count + 1")
  end

  has_many :posts, through: :topics

  def remove_post(post)
    self.path.each { |f| f.update_last_post if post.id == f.last_post_id }
  end

  def remove_topic
    self_path.update_all("topics_count = topics_count - 1")
  end

  def update_last_post
    last_post = ForumPost.joins(:topic).where(forum_topics: {forum_id: self.subtree_ids}).last
    self.update({
                    last_post_id: last_post.id,
                    last_post_topic_id: last_post.topic_id,
                    last_post_char_name: last_post.char.name,
                    last_post_at: last_post.created_at
                })
  end

  scope :categories, ->{where(is_category: 1)}
  scope :forums, ->{where(is_category: 0)}

  def child_categories
    self.children.categories
  end

  def child_forums
    self.children.forums
  end

end
