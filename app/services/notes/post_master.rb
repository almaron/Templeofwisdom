module Notes
  class PostMaster < SystemNote
    class << self
      def create(topic, post, comment='')
        masters.each { |user| create_note(user, topic, post, comment) }
      end

      private

      def masters
        User.where(group:['master','admin'])
      end

      def create_note(user, topic, post, comment)
        Notification.create({
          user_id: user.id,
          priority: 2,
          head: I18n.t('notifications.system.head.notify_post_master'),
          text: render(partial: 'shared/notifications/notify_post_master', locals: {topic: topic, post: post, comment:comment})
        })
      end
    end
  end
end