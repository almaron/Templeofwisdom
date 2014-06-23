class CharRole < ActiveRecord::Base

  belongs_to :char
  belongs_to :role

  has_many :role_skills, class_name: CharRoleSkill, dependent: :destroy
  accepts_nested_attributes_for :role_skills, allow_destroy: true

  attr_accessor :logic_points, :style_points, :skill_points, :volume_points, :added_points, :comment

  before_save :calculate_points

  def calculate_points
    self.points = (logic_points + style_points + skill_points)/20 * volume_points + added_points if self.logic_points
  end

  after_initialize :set_points

  def set_points
    if self.new_record?
     self.logic_points = self.style_points = self.skill_points = 10
     self.volume_points = 20
     self.added_points = 0
    end
  end


end
