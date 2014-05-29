json.extract! @guest_post, :id, :head, :content, :answer, :user, :ip
json.postDate I18n.l(@guest_post.created_at, format: :full)
if @guest_post.answer.present?
  json.answerDate I18n.l(@guest_post.updated_at, format: :full)
  json.hasAnswer true
end