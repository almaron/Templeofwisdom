json.extract! @guest_post, :head, :content, :answer, :user, :ip
json.createDate I18n.l(guest.post.created_at)
json.answerDate I18n.l(@guest_post.updated_at) if @guest_post.answer.present?