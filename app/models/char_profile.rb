class CharProfile < ActiveRecord::Base

  belongs_to :char

  validates :age, :numericality => true
  validates :birth_date, :format => /\A\d{1,2}\.\d{1,2}\z/

  trimmed_fields :birth_date, :age, :real_age, :bio, :place, :beast, :phisics, :look, :character, :items, :person, :comment, :other

  after_initialize :init_default

  def real_age
    if self.birth_date.present?
      this_year = AdminConfig.find_by(name: 'current_year').value.to_i
      this_season = SeasonTime.where("begins <= #{Time.now.strftime('%m%d')}").last.try(:season_id) || 1
      new_age = this_season <= read_season_id ? self.age + (this_year - 2) : self.age + (this_year - 1)
    else
      new_age = self.age
    end
    new_age
  end

  def real_age=(number=0)
    number = number.to_i
    this_year = AdminConfig.find_by(name: 'current_year').value.to_i
    this_season = SeasonTime.where("begins <= #{Time.now.strftime('%m%d')}").last.try(:season_id) || 1
    self.age = this_season <= read_season_id ? number - (this_year-2) : number - (this_year - 1)
  end

  private

  def init_default
    self.points ||= 0
  end

  def read_season_id
    month = self.birth_date.split('.')[-1].to_i
    if month < 3 || month >= 11
      season_id = 1
    elsif month <= 5
      season_id = 2
    elsif month <= 8
      season_id = 3
    else
      season_id = 4
    end
    season_id
  end

end
