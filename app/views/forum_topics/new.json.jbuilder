json.path @forum.path do |forum|
  json.(forum, :id, :name)
end

json.topic do
  json.(@topic, :head, :hidden)
end

json.post do
  json.(@post, :char_id, :text)
end

json.chars @chars do |char|
  json.(char, :id, :name)
  json.avatar_img image_tag(char.avatar_url(:thumb))
end