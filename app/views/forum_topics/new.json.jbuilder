json.path @forum.path do |forum|
  json.(forum, :id, :name)
end

json.topic do
  json.(@topic, :head, :hidden)
end

json.post do
  json.(@post, :char_id, :text, :avatar_id)
end

json.chars @chars do |char|
  json.(char, :id, :name)
  json.default char.default?(current_user)
  json.avatars char.avatars, partial: 'char_avatars/char_avatar', as: :avatar
end
