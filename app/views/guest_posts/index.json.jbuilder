json.array! @posts do |guest_post|
  json.extract! guest_post, :id, :head, :user, :ip, :content, :answer
  json.url guest_post_url(guest_post, format: :json)
  json.postDate I18n.l(guest_post.created_at)
  if guest_post.answer.present?
    json.answerDate I18n.l(guest_post.updated_at)
    json.hasAnswer true
  end

end
