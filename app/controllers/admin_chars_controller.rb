class AdminCharsController < ApplicationController

  before_action :admin_access
  before_action :get_char, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html { }
      format.json {
        @active_chars = Char.includes(:profile).where("status_id >= 1")

      }
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def get_char
    @char = Char.find(params[:id])
  end

  def char_params
    params.require(:char).permit(:name, :group_id, :status_line, :status_id, :avatar, :remote_avatar_url, :open_player, profile_attributes:[:birth_date, :age, :real_age, :season_id, :place, :beast, :phisics, :bio, :look, :character, :items, :person, :comment, :points, :other], char_skills_attributes:[:skill_id, :level_id])
  end


end
