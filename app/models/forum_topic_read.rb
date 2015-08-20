class ForumTopicRead < ActiveRecord::Base
  belongs_to :forum_topic
  belongs_to :user

  class << self

  end
end
