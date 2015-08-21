class ForumDraftsController < ApplicationController

  before_action :require_login

  def index
    @drafts = current_user.forum_drafts.eager_load(:topic).order(:id)
  end

  def create
    @draft = ForumDraft.build_from draft_params
    if @draft.save
      render json: { success: I18n.t('messages.notice.drafts.save.success') }
    else
      render json: { failure: @draft.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    current_user.forum_drafts.find_by(id: params[:id]).try(:delete)
    respond_to do |format|
      format.html { redirect_to drafts_profile_path, notice: t('messagrs.notice.draft.deleted')}
      format.json { render json: { success: t('messagrs.notice.draft.deleted') } }
      format.js { render js: "$('#draft_#{params[:id]}').remove()" }
    end
  end

  private

  def draft_params
    pp = params.require(:draft).permit(:topic_id, :user_id, :char_id, :avatar_id, :text)
    pp.merge user_id: current_user.id, topic_id: params[:topic].to_i
  end

end
