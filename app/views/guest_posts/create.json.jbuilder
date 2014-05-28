json.extract! @guest_post, :head, :content, :answer, :user, :ip
json.postDate I18n.l(@guest_post.created_at)
if @guest_post.answer.present?
  json.answerDate I18n.l(@guest_post.updated_at)
  json.hasAnswer true
end