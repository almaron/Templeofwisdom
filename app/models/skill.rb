class Skill < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :skill_levels, dependent: :destroy
  accepts_nested_attributes_for :skill_levels

  after_create :create_levels

  default_scope { order(:name) }

  scope :magic, ->{where(skill_type: "magic")}
  scope :phisic, ->{where(skill_type: "phisic")}

  def has_discount?(skill_ids)
    return false if discount.empty? || skill_ids.empty?
    search_discount(skill_ids)
  end


  private

  def search_discount(skill_ids)
    (discount.split(',').map {|i| i.to_i} & skill_ids).any?
  end

  def create_levels
     (1..Level.count).each { |int| self.skill_levels.create(level_id: int)}
  end
end
