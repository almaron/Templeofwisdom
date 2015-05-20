module ApplicationHelper

  def topic_full_path(topic)
    forum_topic_path topic.forum_id, topic.id
  end

  def ssi(path)
    raw "<!--# include virtual='#{path}' stub='error' -->"
  end

  def flash_div_class
    flash.keys.first.to_s
  end

  def flash_div_message
    flash[flash.keys.first]
  end

end
