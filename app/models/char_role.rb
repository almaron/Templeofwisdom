class CharRole < ActiveRecord::Base

  belongs_to :char
  belongs_to :role

  has_many :role_skills, class_name: CharRoleSkill, dependent: :destroy
  accepts_nested_attributes_for :role_skills, allow_destroy: true
  has_many :skills, through: :role_skills

  attr_accessor :logic_points, :style_points, :skill_points, :volume_points, :added_points, :comment, :staged_points

  before_save :calculate_points

  def calculate_points
    self.points = (logic_points.to_i + style_points.to_i + skill_points.to_i)/20 * volume_points.to_i + added_points.to_i if self.logic_points
  end

  after_initialize :set_points

  def set_points
    if self.new_record?
     self.logic_points  ||= 10
     self.style_points  ||= 10
     self.skill_points  ||= 10
     self.volume_points ||= 20
     self.added_points  ||= 0
    else
      self.staged_points = self.points
    end
  end

  after_update :recalculate_points

  def recalculate_points
    profile = CharProfile.find_by(char_id:self.char_id)
    diff_points = profile.points + self.points - self.staged_points
    profile.update(points: diff_points)
  end


end
