class Forum < ActiveRecord::Base

  has_ancestry

  has_many :topics, class_name: ForumTopic

  default_scope {order(:sort_order)}

  def add_post(post)
    self.path.update_all({
                    last_post_id: post.id,
                    last_post_topic_id: post.topic_id,
                    last_post_char_name: post.char.name,
                    last_post_char_id: post.char_id,
                    last_post_at: post.created_at
                })
    self.path.update_all("posts_count = posts_count + 1")
  end

  def add_topic
    self.path.update_all("topics_count = topics_count + 1")
  end


  def remove_post(post)
    self.path.each { |f| f.update_last_post if post.id == f.last_post_id }
    self.path.update_all("posts_count = posts_count - 1")
  end

  def remove_topic(topic = nil)
    self.path.update_all("topics_count = topics_count - 1")
    if topic
      self.path.each { |f| f.update_last_post if topic.id == f.last_post_topic_id }
    end
  end

  def update_last_post
    last_post = ForumPost.joins(:topic).where(forum_topics: {forum_id: self.subtree_ids}).last
    if last_post
      self.update({
                    last_post_id: last_post.id,
                    last_post_topic_id: last_post.topic_id,
                    last_post_char_name: last_post.char.name,
                    last_post_char_id: last_post.char_id,
                    last_post_at: last_post.created_at
                })
    else
      self.update({
                      last_post_id: nil,
                      last_post_topic_id: nil,
                      last_post_char_name: nil,
                      last_post_char_id: nil,
                      last_post_at: nil,
                  })
    end
  end

  def visible_children(user)
    children.select {|f| f.is_visible?(user)}
  end

  def child_categories(user)
    self.children.select {|f| f.is_visible?(user) && f.is_category?}
  end

  def child_forums(user)
    self.children.select {|f| f.is_visible?(user) && !f.is_category?}
  end

  def is_visible?(user)
    !hidden? || (user.present? && (user.is_in?(:admin) || user.has_privilege?))
  end

end
