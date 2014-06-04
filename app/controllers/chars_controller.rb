class CharsController < ApplicationController

  before_action :require_login, :except => [:index, :show]
  before_action :get_char, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {}
      format.json { @chars = Char.includes(:profile).all }
    end
  end

  def show
    @only_content = true
    respond_to do |format|
      format.html { }
      format.json { }
    end
  end

  def new
    @char = Char.new
    @char.build_profile
  end

  def create
    @char = Char.new(char_params)
    @char.creator = current_user
    respond_to do |format|
      if @char.save
        format.html { redirect_to profile_path, notice: t("messages.notice.chars.create.success") }
        format.js {render js: "window.location = '#{profile_path}'", notice: t("messages.notice.chars.create.success") }
        format.json { render nothing: true }
      else
        format.html { render :new }
        format.js   { render js: "$('span.form-errors').show();"}
        format.json { render json: @char.errors.full_messages }
      end
    end
  end

  def edit
    if @char.status_id > 1
      redirect_to profile_path, alert: t("messages.alert.chars.edit.not_editable")
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @char.status_id > 1
        format.html { redirect_to profile_path, alert: t("messages.alert.chars.edit.not_editable") }
        format.js { render js: "window.location = #{profile_path}", alert: t("messages.alert.chars.edit.not_editable")}
      elsif @char.update(char_params)
        format.html { redirect_to profile_path, notice: t("messages.notice.chars.update.success") }
        format.js { render js: "window.location = #{profile_path}", alert: t("messages.alert.chars.edit.not_editable") }
      else
        format.html { render :new }
        format.js { render js: "$('span.form-errors').show();" }
      end
    end
  end

  def destroy
    if @char.status_id == 1
      @char.destroy
      redirect_to profile_path
    end
  end

  def engine
    respond_to do |format|
      format.json {
        @access_groups = CharGroup.accessible_by(current_user.group)
      }
    end
  end

  def check_name
    respond_to do |format|
      format.json {
        render json: Char.find_by(name:params[:name]) ? true : false
      }
    end
  end

  private

  def get_char
    @char = Char.find(params[:id])
  end

  def char_params
    params.require(:char).permit(
        :name, :remote_avatar_url, :group_id,
        char_skills_attributes:[
            :skill_id, :level_id
        ],
        profile_attributes: [
            :birth_date, :real_age, :season_id, :beast, :place, :phisics, :look, :bio, :items, :character, :other
        ]
    )
  end
end
