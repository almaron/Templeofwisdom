class ForumDraftsController < ApplicationController

  before_action :require_login

  def index
    @drafts = current_user.drafts.eager_load(:topic).order(:id)
  end

  def create
    @draft = ForumDraft.build_from draft_params
    if @draft.save
      render json: { success: I18n.t('messages.notice.drafts.save.success') }
    else
      render json: { failure: @draft.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def draft_params
    pp = params.require(:draft).permit(:topic_id, :user_id, :char_id, :avatar_id, :text)
    pp.merge user_id: current_user.id, topic_id: params[:topic].to_i
  end

end
