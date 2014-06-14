class ForumTopic < ActiveRecord::Base

  validates_presence_of :head

  has_many :posts, class_name: ForumPost, foreign_key: :topic_id
  accepts_nested_attributes_for :posts

  belongs_to :forum

  scope :shown, ->{where(hidden:0)}

  def add_post(post)
    update_last_post post
    forum.add_post post
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