json.(forum, :id, :name, :last_post_topic_id, :last_post_id, :last_post_char_name, :topics_count, :posts_count)
json.last_post_at I18n.l(forum.last_post_at) if forum.last_post_at
json.isCategory forum.is_category > 0
if forum.is_category == 0
  json.(forum, :image, :description, :hidden, :technical)
end