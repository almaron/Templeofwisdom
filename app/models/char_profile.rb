class CharProfile < ActiveRecord::Base
  belongs_to :char

  validates :age, :numericality => true
  validates :birth_date, :format => /\A\d{2}\.\d{2}\z/

  after_initialize :init_default

  def real_age
    if self.age && self.season_id
      this_year = AdminConfig.find_by(name: 'current_year').value.to_i
      this_season = SeasonTime.where("begins <= #{Time.now.strftime('%m%d')}").last.try(:season_id) || 1
      new_age = this_season < self.season_id ? self.age + (this_year - 1) : self.age + (this_year - 2)
    else
      self.age
    end
  end

  private

  def init_default
    self.points = 0 unless self.points > 0
    self.real_age if self.birth_date
  end

  def real_age=(number)
    self.season_id ||= 1
    this_year = AdminConfig.find_by(name: 'current_year').value.to_i
    this_season = SeasonTime.where("begins <= #{Time.now.strftime('%m%d')}").last.try(:season_id) || 1
    self.age = number - (this_year - 1)
    self.age += 1 if this_season < self.season_id
  end

end
