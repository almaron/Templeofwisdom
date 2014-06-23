class AdminCharsController < ApplicationController

  before_action :admin_access
  before_action :get_char, only: [:update, :destroy, :accept, :approve, :decline]
  # before_action :set_only_content

  def index
    respond_to do |format|
      format.html { }
      format.json {
        where = case params[:scope]
                  when 'playable'
                    {status_id: 5}
                  when 'pending'
                    {status_id: 2}
                  when 'reviewed'
                    {status_id: [3,4]}
                  when 'saved'
                    {status_id: 1}
                  else
                    {status_id:[5,6]}
                end
        @chars = Char.eager_load(:profile, :group, :status).where(where)
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

  # noinspection RubyResolve
  def update
    @char.char_skills.destroy_all
    respond_to do |format|
      if @char.update char_params
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
    respond_to do |f|
      f.html { redirect_to admin_chars_path }
      f.json { render :json => {success: true} }
    end
  end

  def approve
    @char.approve current_user
    respond_to do |f|
      f.html { redirect_to admin_chars_path }
      f.json { render :json => {success: true} }
    end
  end

  def decline
    @char.decline
    respond_to do |f|
      f.html { redirect_to admin_chars_path }
      f.json { render :json => {success: true} }
    end
  end

  def destroy
    @char.remove
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


end
