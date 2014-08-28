class SkillRequestsController < ApplicationController

  def index
    @requests = SkillRequest.includes(:char, :skill, :level).all
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def user_index
    @requests = current_user.skill_requests.includes(:char, :skill, :level).all
  end

  def create
    char = Char.find(params[:char_id])
    level = char.get_skill_level(params[:skill_id]) + 1
    @request = SkillRequest.new(char_id: char.id, user_id: char.owner.id, skill_id: params[:skill_id], level_id: level)
    respond_to do |format|
      if @request.initiate! current_user
        format.json { render json: {success: I18n.t('messages.notice.skill_requests.create.success')} }
      else
        format.json { render json: {failure: I18n.t('messages.alert.skill_requests.create.failure')}, status: :unprocessable_entity}
      end
    end
  end

  def update
    SkillRequest.find(params[:id]).accept
    render nothing: true
  end

  def destroy
    SkillRequest.find(params[:id]).decline
    render nothing: true
  end

end