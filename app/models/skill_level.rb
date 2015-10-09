class SkillLevel < ActiveRecord::Base

  belongs_to :skill
  belongs_to :level

  after_update :touch_skill

  def touch_skill
    skill.touch
  end
end
