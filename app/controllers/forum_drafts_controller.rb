class ForumDraftsController < ApplicationController

  before_action :require_login

  def index
    @post_drafts = current_user.forum_post_drafts.eager_load(:topic).order(:id)
    @topic_drafts = current_user.forum_topic_drafts.eager_load(:forum).order(:id)
  end

  def create
    @draft = draft_class.build_from draft_params
    if @draft.save
      render json: { success: I18n.t('messages.notice.drafts.save.success') }
    else
      render json: { failure: @draft.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete

    current_user.send(draft_association).find_by(id: params[:id]).try(:delete)
    respond_to do |format|
      format.html { redirect_to drafts_profile_path, notice: t('messagrs.notice.draft.deleted')}
      format.json { render json: { success: t('messagrs.notice.draft.deleted') } }
      format.js { render js: "$('##{params[:type]}_draft_#{params[:id]}').remove()" }
    end
  end

  private

  def draft_params
    pp = params.require(:draft).permit(:topic_id, :user_id, :char_id, :avatar_id, :text, :head, :forum_id)
    pp.merge user_id: current_user.id, topic_id: params[:topic].to_i, forum_id: params[:forum].to_i
  end

  def draft_class
    params[:type] == 'post' ? ForumPostDraft : ForumTopicDraft
  end

  def draft_association
    params[:type] == 'post' ? :forum_post_drafts : :forum_topic_drafts
  end

end
