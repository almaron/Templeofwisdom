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

  def forum_navigation(pages)
    will_paginate pages, class: 'pagination paginator align-center', renderer: PageRenderer
  end

  def forum_link(forum)
    link_to forum.name, forum_path(forum)
  end

end
