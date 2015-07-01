class AdminCharsController < ApplicationController

  before_action :admin_access
  before_action :get_char, only: [:update, :destroy, :accept, :approve, :decline, :restore]
  # before_action :set_only_content

  def index
    respond_to do |format|
      format.html { }
      format.json {
        @chars = Char.eager_load(:profile, :group, :status, :avatars).where(status_id: where_status)
      }
    end
  end

  def show
    @char = Char.eager_load(:profile, :char_skills, :char_delegations).find(params[:id])
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def edit

  end

  def update
    @char.clear_skills
    respond_to do |format|
      if @char.update char_params
        Loggers::CharProfile.new(current_user).log char_name: @char.name
        format.html { redirect_to admin_chars_path }
        format.json { render json: {success:true}  }
        format.js   {  }
      else
        format.html { redirect_to admin_chars_path }
        format.json { render json: {success:false}  }
        format.js   {  }
      end
    end
  end

  def accept
    @char.accept current_user
    Loggers::Char.new(current_user).log char_name: self.name, action: 'accept'
    respond_to do |f|
      f.html { redirect_to admin_chars_path }
      f.json { render :json => {success: true} }
    end
  end

  def approve
    @char.approve current_user
    Loggers::Char.new(user).log char_name: self.name, action: 'approve'
    respond_to do |f|
      f.html { redirect_to admin_chars_path }
      f.json { render :json => {success: true} }
    end
  end

  def decline
    @char.decline current_user
    Loggers::Char.new(user).log char_name: self.name, action: 'decline'
    respond_to do |f|
      f.html { redirect_to admin_chars_path }
      f.json { render :json => {success: true} }
    end
  end

  def destroy
    @char.remove current_user
    Loggers::Char.new(user).log char_name: self.name, action: 'destroy'
    respond_to do |format|
      format.html { redirect_to admin_chars_path }
      format.json { render json: {success: true} }
    end
  end

  def restore
    @char.restore current_user
    Loggers::Char.new(user).log char_name: self.name, action: 'restore'
    respond_to do |format|
      format.html { redirect_to admin_chars_path }
      format.json { render json: {success: true} }
    end
  end

  private

  def get_char
    id = params[:id] || params[:admin_char_id]
    @char = Char.find id
  end

  def char_params
    params.require(:char).permit(:name, :group_id, :status_line, :status_id, :avatar, :remote_avatar_url, :open_player, profile_attributes:[:birth_date, :age, :real_age, :season_id, :place, :beast, :phisics, :bio, :look, :character, :items, :person, :comment, :points, :other], char_skills_attributes:[:skill_id, :level_id])
  end

  def set_only_content
    @only_content = true
  end

  SCOPES = {
    playable: 5,
    pending: 2,
    reviewed: [3,4],
    saved: 1,
    messagable: (2..5).to_a
  }

  def where_status
    params[:scope] ? SCOPES[params[:scope].to_sym] || [5,6] : [5,6]
  end
end
