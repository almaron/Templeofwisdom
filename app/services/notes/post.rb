module Notes
  class Post < SystemNote
    def create(char_ids, topic, post)
      if char_ids
        char_ids.each { |cid| each_char(cid, topic, post) }
      end
    end

    def create_note(user=nil, topic, post)
      Notification.create({
        user_id: user.id,
        head: I18n.t('notifications.system.head.notify_post'),
        text: render(partial: 'shared/notifications/notify_post', locals: {topic: topic, post: post})
      }) if user
    end

    def each_char(id, topic, post)
      create_note Char.find(id).owner, topic, post
    end
  end
end
