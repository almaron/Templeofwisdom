class CharsController < ApplicationController

  before_action :require_login, :except => [:index, :show]
  before_action :get_char, only: [:edit, :update, :destroy, :small_update]

  def index
    respond_to do |format|
      format.html { @chars = Char.where("group_id IN (?)", [2,3,4,5]).where(status_id:5) }
      format.json { @chars = Char.includes(:profile).all }
    end
  end

  def show
    if params[:short]
      @char = Char.includes(:profile, :char_skills).find(params[:id])
    else
      @char = Char.includes(:profile, :char_skills, :status, :group, :users).find(params[:id])
    end
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
        format.js { render js: "window.location = '#{profile_path}'", alert: t("messages.alert.chars.edit.not_editable")}
      else
        @char.char_skills.destroy_all
        if @char.update(char_params)
          format.html { redirect_to profile_path, notice: t("messages.notice.chars.update.success") }
          format.js { render js: "window.location = '#{profile_path}'", alert: t("messages.alert.chars.edit.not_editable") }
        else
          format.html { render :new }
          format.js { render js: "$('span.form-errors').show();" }
        end
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

  def small_update
    value = case params[:field]
      when "points"
        @char.profile.points += params[:value]
      when "person"
        @char.profile.person = params[:person]
      when "comment"
        @char.profile.comment = params[:comment]
      else
        nil
    end
    @char.save
    respond_to do |format|
      format.json { render json: {value: value}}
      format.js {}
    end
  end

  private

  def get_char
    @char = Char.find(params[:id])
  end

  def char_params
    params.require(:char).permit(
        :name, :remote_avatar_url, :avatar, :group_id, :open_payer,
        char_skills_attributes:[
            :skill_id, :level_id
        ],
        profile_attributes: [
            :birth_date, :real_age, :season_id, :beast, :place, :phisics, :look, :bio, :items, :character, :other, :person
        ]
    )
  end



end
