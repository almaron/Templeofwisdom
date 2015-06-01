module Notes
  class SkillRequest < SytemNote
    def create(request, message="accept")
      Notification.create({
        user_id: request.user_id,
        head: I18n.t("notifications.system.head.notify_skill_request.#{message}"),
        text: render(partial: "shared/notifications/notify_skill_request_#{message}", locals: {request: request})
      })
    end
  end
end