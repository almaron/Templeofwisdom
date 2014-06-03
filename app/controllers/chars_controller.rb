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

  end

  def new
    @char = Char.new
    @char.build_profile
  end

  def create
  end

  def edit
    if @char.status_id > 1
      redirect_to profile_path, alert: t("messages.alert.chars.edit.not_editable")
    end
  end

  def update
    if @char.status_id > 1
      redirect_to profile_path, alert: t("messages.alert.chars.edit.not_editable")
    elsif @char.update(char_attributes)
      redirect_to profile_path, notice: t("messages.notice.chars.update.success")
    else
      render :edit
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
        @access_groups = CharGroup.accessible(current_user.group)
      }
    end
  end

  private

  def get_char
    @char = Char.find(params[:id])
  end

end
