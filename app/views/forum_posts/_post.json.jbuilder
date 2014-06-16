json.(post, :id, :text, :comment, :commenter, :char_id, :ip)
json.show_text simple_format(post.text.bbcode_to_html)
json.posted_at I18n.l(post.created_at, format: :full) if post.created_at
json.commented_at I18n.l(post.commented_at, format: :full) if post.commented_at

json.char do
  json.(post.char, :id, :name)
  json.status post.char.status_line || I18n.t("char_groups.names.#{post.char.group.name}")
  json.avatar_img image_tag(post.char.avatar_url(:thumb)) if post.char.avatar?
end

json.editable post_editable post
json.deletable post_deletable post
json.commentable post_commentable

json.user do
  json.(post.user, :id, :name)
end