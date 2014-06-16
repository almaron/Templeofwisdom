json.path @topic.forum.path do |forum|
  json.(forum, :id, :name)
end

json.topic do
  json.(@topic, :id, :head, :hidden, :closed, :last_post_id)
  json.technical @topic.forum.technical > 0
  json.description @topic.forum.description
  json.pages_count (@topic.posts.count.to_f / 15).ceil
end