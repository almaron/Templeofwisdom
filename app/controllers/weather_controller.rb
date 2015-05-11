class WeatherController < ApplicationController

  layout false

  def show
    @season = Season.find season_id
  end

  private

  def season_id
    SeasonTime.where("begins <= #{Time.now.strftime('%m%d')}").last.try(:season_id) || 1
  end
end
