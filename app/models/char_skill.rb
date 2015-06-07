class CharSkill < ActiveRecord::Base
  belongs_to :char
  belongs_to :skill
  belongs_to :level

  default_scope { order(:level_id) }
  scope :phisic, ->{ includes(:skill).where(skills:{skill_type:"phisic"}) }
  scope :magic, ->{ includes(:skill).where(skills:{skill_type:"magic"}) }
end
