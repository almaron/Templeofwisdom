module Notes
  class Question < SystemNote
    def create(question, user)
      Notification.create({
        user_id: question.user_id,
        head: I18n.t('notifications.system.head.notify_user_question_answer'),
        text: render(partial: 'shared/notifications/notify_char_accept', locals: {question: question, user: user})
      })
    end
  end
end
