require 'render_anywhere'
class NoteService
  include RenderAnywhere

  def notify_post(char_ids, topic, post)
    if char_ids
      char_ids.each do |cid|
        user = Char.find(cid).owner
        if user
          Notification.create({
            user_id: user.id,
            head: I18n.t('notifications.system.head.notify_post'),
            text: render(partial: 'notifications/system/notify_post', locals: {topic: topic, post: post})
          })
        end
      end
    end
  end

  def notify_post_master(topic, post, comment='')
    User.where(group:['master','admin']).each do |user|
      Notification.create({
        user_id: user.id,
        priority: 2,
        head: I18n.t('notifications.system.head.notify_post_master'),
        text: render(partial: 'notifications/system/notify_post_master', locals: {topic: topic, post: post, comment:comment})
      })
    end
  end

  def notify_char_accept(char)
    Notification.create({
      user_id: char.owner.id,
      head: I18n.t('notifications.system.head.notify_char_accept'),
      text: render(partial: 'notifications/system/notify_char_accept', locals: {char: char})
    })
  end

  def notify_char_approve(char)
    Notification.create({
                            user_id: char.owner.id,
                            head: I18n.t('notifications.system.head.notify_char_approve'),
                            text: render(partial: 'notifications/system/notify_char_approve', locals: {char: char})
                        })
  end

  def notify_char_decline(char)
    Notification.create({
                            user_id: char.owner.id,
                            head: I18n.t('notifications.system.head.notify_char_decline'),
                            text: render(partial: 'notifications/system/notify_char_decline', locals: {char: char})
                        })
  end

end