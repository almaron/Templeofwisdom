class ForumTopic < ActiveRecord::Base

  validates_presence_of :head

  has_many :posts, class_name: ForumPost, foreign_key: :topic_id
  accepts_nested_attributes_for :posts
  has_many :chars, through: :posts

  belongs_to :forum

  scope :shown, ->{where(hidden:0)}

  def add_post(post)
    update_last_post post
    forum.add_post post
  end


  def remove_post(post)
    self.posts.empty? ? self.destroy : update_last_post(self.posts.last, -1)
    self.forum.remove_post(post) if self.forum
  end

  def is_available?(user)
    self.hidden == 0 || (user && user.is_in?([:admin, :master]))
  end

  def is_editable?(user)
    user && (user.is_in?([:admin, :master]) || self.posts.first.char.delegated_to?(user))
  end

  after_destroy :remove_topic

  def remove_topic
    self.forum.remove_topic self
  end

  after_create :add_topic

  def add_topic
    self.forum.add_topic
  end

  def play_chars
    self.chars.where('group_id > 1').uniq
  end

  private

  def update_last_post(post, inc=1)
    self.update({
                    last_post_id: post.id,
                    last_post_char_name: post.char.name,
                    last_post_char_id: post.char_id,
                    last_post_at: post.created_at,
                    posts_count: self.posts_count + inc
                })
  end

end