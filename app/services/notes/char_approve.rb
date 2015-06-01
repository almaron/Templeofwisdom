module Notes
  class CharApprove < SystemNote
    class << self
      def create(char)
        Notification.create({
          user_id: char.owner.id,
          head: I18n.t('notifications.system.head.notify_char_approve'),
          text: render(partial: 'shared/notifications/notify_char_approve', locals: {char: char})
        })
      end
    end
  end
end