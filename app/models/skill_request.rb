class SkillRequest < ActiveRecord::Base

  validates_presence_of :char_id, :user_id, :skill_id, :level_id

  belongs_to :char
  belongs_to :user
  belongs_to :skill
  belongs_to :level
  belongs_to :forum_post

  before_save :calculate_points_and_roles

  def acceptable?
    char.has_enough_points?(points) && char.has_enough_role_skills?(skill_id, roles)
  end

  def accept
    if acceptable?
      set_char_skill
      update_request_post
      send_notification_to_user
      self.destroy
      recalculate_requests
    end
  end

  def decline
    update_request_post "decline"
    send_notification_to_user "decline"
  end

  def calculate_points_and_roles(save=false)
    self.points = level.send(points_column)
    self.roles = level.send(roles_column)
    self.save if save
  end

  private

  def set_char_skill
    char_skill = char.char_skills.find_or_initialize_by(skill_id:skill_id)
    transaction do
      char.role_skills.where(skill_id:skill_id, done:0).limit(roles).update_all(done:1)
      char_skill.update(level_id: level_id)
      char.remove_points points
    end
  end

  def update_request_post(message='accept')
    forum_post.update(comment: I18n.t("messages.forum.#{message}_skill_request"), commenter:I18n.t('messages.forum.commenter'), commented_at: DateTime.now)
  end

  def send_notification_to_user(message="accept")
    NoteService.new.notify_skill_request self, message
  end

  def points_column
    "#{skill.skill_type}_points#{skill.has_discount?(char.master_skill_ids) ? "_discount" : ""}"
  end

  def roles_column
    "#{skill.skill_type}_roles"
  end

  def recalculate_requests
    if level_id >= 5
      Skill.where("discount LIKE '%,:skill_id%' OR discount LIKE '%:skill_id,%'", {:skill_id => skill_id})
    end
  end

end