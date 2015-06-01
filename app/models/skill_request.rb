class SkillRequest < ActiveRecord::Base

  validates_presence_of :char_id, :user_id, :skill_id, :level_id

  belongs_to :char
  belongs_to :user
  belongs_to :skill
  belongs_to :level
  belongs_to :forum_post

  after_initialize :calculate_points_and_roles, if: ->{ new_record? }

  ['char','skill','user','level'].each do |item|
    define_method "#{item}_name" do
      self.send(item).name
    end
  end

  def acceptable?
    char.has_enough_points?(points) && char.has_enough_role_skills?(skill_id, roles)
  end

  def initiate!(user)
    if acceptable? && ( post_id = SystemPosts::SkillRequestPost.new(user, self).create )
      self.forum_post_id = post_id
      save
    end
  end

  def add_new?
    level_id == 1
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
    self.destroy
  end

  def calculate_points_and_roles(save=false)
    self.points = level.send(points_column)
    self.roles = level.send(roles_column)
    self.save if save
  end

  private

  def set_char_skill
    char_skill = char.get_char_skill skill_id
    char_skill.level_id = level_id
    transaction do
      char.mark_skill_done skill_id, roles
      char_skill.save
      char.remove_points points
    end
  end

  def update_request_post(message='accept')
    forum_post.update(comment: I18n.t("messages.forum.#{message}_skill_request"), commenter:I18n.t('messages.forum.commenter'), commented_at: DateTime.now)
  end

  def send_notification_to_user(message="accept")
    Notes::SkillRequest.create self, message
  end

  def points_column
    if skill.skill_type == 'phisic'
      "phisic_points#{"_discount" if skill.has_discount?(char.master_skill_ids)}"
    else
      "magic_points#{"_discount" if skill.has_discount?(char.magic_skill_ids)}"
    end
  end

  def roles_column
    "#{skill.skill_type}_roles"
  end

  # noinspection RailsParamDefResolve
  def recalculate_requests
    if level_id >= 5
      skill_ids = Skill.where("discount LIKE '%,:skill_id%' OR discount LIKE '%:skill_id,%'", {:skill_id => skill_id}).pluck :id
      char.skill_requests.where(skill_id:skill_ids).each {|request| request.calculate_points_and_roles(true)}
    end
  end

end