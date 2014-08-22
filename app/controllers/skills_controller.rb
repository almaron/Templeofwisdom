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
    respond_to do |format|
      format.html {}
      format.json { render json: @skill, except: [:created_at, :updated_at], include: {skill_levels:{except:[:created_at, :updated_at], include: {level: {only: :name}}}} }
    end
  end

  def create
    @skill = Skill.new(name: params[:skill_name], skill_type: params[:skill_type])
    respond_to do |f|
      if @skill.save
        f.json { render json: @skill, except: [:created_at, :updated_at], include: {skill_levels:{except:[:created_at, :updated_at], include: {level: {only: :name}}}} }
      else
        f.json { render json: @skill.errors, status: 500}
      end
    end
  end

  def update
    @skill = Skill.includes(skill_levels:[:level]).find(params[:id])
    debugger
    respond_to do |f|
      if @skill.update skill_params
        f.json { render json: @skill, except: [:created_at, :updated_at], include: {skill_levels:{except:[:created_at, :updated_at], include: {level: {only: :name}}}} }
      else
        f.json { render json: @skill.errors, status: 500}
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

  private

  def skill_params
    params.require(:skill).permit(:id, :name, :description, :advice, :discount, skill_levels_attributes: [:id, :skill_id, :level_id, :description, :advice, :techniques])
  end
end
