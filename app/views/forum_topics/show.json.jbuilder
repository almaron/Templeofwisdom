json.path @topic.forum.path do |forum|
  json.(forum, :id, :name)
end

json.topic do
  json.(@topic, :id, :head, :hidden, :closed, :last_post_id)
  json.technical @topic.forum.technical > 0
  json.isHidden @topic.hidden && @topic.hidden > 0
  json.isClosed @topic.closed && @topic.closed > 0
  json.editable @topic.is_editable?(current_user)
  json.description @topic.forum.description
  json.pages_count (@topic.posts.count.to_f / 15).ceil
  json.chars @topic.other_chars(current_user) do |char|
    json.(char, :id, :name)
  end
end

json.chars @chars do |char|
  json.(char, :id, :name)
end
