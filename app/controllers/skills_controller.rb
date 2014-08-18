class SkillsController < ApplicationController

  before_action :admin_access, only: [:index, :create, :update, :destroy]
  def index
    respond_to do |format|
      format.html {  }
      format.json {
        @skills = Skill.all
        render json: @skills, only: [:id, :name, :skill_type]
      }
    end
  end

  def public_index
    @skills = Skill.select(:id, :name).where(skill_type: params[:skill_type])
  end

  def show
    @skill = Skill.includes(skill_levels: [:level]).find(params[:id])
  end

  def create
    @skill = Skill.create(name: params[:skill_name], skill_type: params[:skill_type])
    respond_to do |f|
      f.json { render :show}
    end
  end

  def update
    @skill = Skill.find(params[:id])
    respond_to do |f|
      if @skill.update skill_params
        f.json { render :show}
      end
    end
  end

  def destroy
    Skill.find(params[:id]).destroy
    respond_to do |f|
      f.html { redirect_to skills_path }
      f.json { render nothing: true }
    end
  end
end
