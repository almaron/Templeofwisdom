json.(forum, :id, :name, :last_post_topic_id, :last_post_id, :last_post_char_name, :last_post_char_id, :last_post_char_id, :topics_count, :posts_count)
json.last_post_at I18n.l(forum.last_post_at, format: :full) if forum.last_post_at
json.isCategory forum.is_category?
json.moderatable forum.is_moderatable?(current_user)
unless forum.is_category?
  json.(forum, :description, :hidden, :technical)
  json.image forum.image_url if forum.image?
end