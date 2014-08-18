class SkillLevel < ActiveRecord::Base

  belongs_to :skill
  belongs_to :level
end
