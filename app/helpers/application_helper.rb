module ApplicationHelper

  def topic_full_path(topic)
    forum_topic_path topic.forum_id, topic.id
  end

end
