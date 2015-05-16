class ForumPost < ActiveRecord::Base

  validates_presence_of :char_id, :ip, :text

  belongs_to :topic, class_name: ForumTopic, foreign_key: :topic_id
  belongs_to :char
  belongs_to :user

  after_create :touch_topic
  before_destroy :check_if_last
  after_destroy :remove_post

  has_one :avatar, class_name: CharAvatar

  def touch_topic
    self.topic.add_post(self)
  end

  def remove_post
    self.topic.remove_post(self) if self.topic
  end

  def check_if_last
    self.topic.last_post_id == self.id
  end

  after_update :set_topic_char

  def set_topic_char
    self.topic.update({char_id: self.char_id, poster_name: self.char.name}) if char_id_changed? && is_first_post?
  end

  def is_first_post?
    self.class.where(topic_id:topic_id).first == id
  end


end
