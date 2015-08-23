json.path @topic.forum.path do |forum|
  json.(forum, :id, :name)
end

json.topic do
  json.(@topic, :id, :head, :hidden, :closed, :last_post_id, :posts_count)
  json.technical @topic.forum.technical > 0
  json.isHidden @topic.hidden?
  json.isClosed @topic.closed?
  json.moderated @topic.is_moderatable?(current_user)
  json.editable @topic.is_editable?(current_user)
  json.description @topic.forum.description.try(:bbcode_to_html_with_formatting)
  json.pages_count (@topic.posts.count.to_f / 15).ceil

  json.current_page @current_page if @current_page


  json.chars @topic.other_chars(current_user) do |char|
    json.(char, :id, :name)
  end
end

if @draft
  json.draft @draft.to_post
end

json.chars @chars do |char|
  json.(char, :id, :name)
  json.default char.default?(current_user)
  json.avatars char.avatars.visible, partial: 'char_avatars/char_avatar', as: :avatar
end
