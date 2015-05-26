json.(post, :id, :text, :comment, :commenter, :char_id, :ip, :avatar_id)
json.show_text post.text.bbcode_to_html_with_formatting
json.posted_at I18n.l(post.created_at, format: :full) if post.created_at
json.commented_at I18n.l(post.commented_at, format: :full) if post.commented_at

json.char do
  json.(post.char, :id, :name, :group_id)
  json.signature post.char.signature.bbcode_to_html_with_formatting
  json.status post.char.status_line || I18n.t("char_groups.names.#{post.char.group.name}")
  json.avatar post.avatar.image_url(:thumb) if post.avatar_id &&
end

json.editable post_editable post
json.deletable post_deletable post
json.commentable post_commentable

json.user do
  json.(post.user, :id, :name)
  json.destroyed post.user.destroyed?
end