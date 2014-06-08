class ForumPost < ActiveRecord::Base

  belongs_to :topic, class_name: ForumTopic, foreign_key: :topic_id
  belongs_to :char
  belongs_to :user

  after_create :touch_topic
  after_destroy :remove_post

  def touch_topic
    self.topic.add_post(self)
  end

  def remove_post
    self.topic.remove_post(self) if self.topic
  end

end
