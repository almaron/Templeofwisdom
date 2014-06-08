class ForumTopic < ActiveRecord::Base

  has_many :posts, class_name: ForumPost, foreign_key: :topic_id

  belongs_to :forum

  def add_post(post)
    update_last_post post
    forum.add_post post
  end

  def create_first_post(params)
    unless self.posts.any?
      self.posts.create params
    end
  end

  def remove_post(post)
    self.posts.empty? ? self.destroy : update_last_post(self.posts.last)
    self.forum.remove_post(post) if self.forum
  end

  private

  def update_last_post(post)
    self.update({
                    last_post_id: post.id,
                    last_post_char_name: post.char.name,
                    last_post_at: post.created_at
                })
  end

end