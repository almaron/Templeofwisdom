class Skill < ActiveRecord::Base
  validates_presence_of :name

  default_scope { order(:name) }

  scope :magic, ->{where(skill_type: "magic")}
  scope :phisic, ->{where(skill_type: "phisic")}
end
