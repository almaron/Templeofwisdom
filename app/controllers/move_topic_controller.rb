class MoveTopicController < ApplicationController

  before_action :check_rights

  def show
    @forums = Forum.where(is_category: 0)
  end

  def update
    @topic = ForumTopic.find(params[:topic_id])
    from_forum_id = @topic.forum_id
    @topic.update(forum_id: params[:forum_id])
    respond_to do |format|
      format.html { redirect_to forum_topic_path(params[:forum_id], params[:topic_id]), notice: t('messages.notice.move_topic.success') }
      format.json { render json: { success: true, message: t('messages.notice.move_topic.success') } }
    end
    recalculate_posts_and_topics(from_forum_id, params[:forum_id])
  end

  def destroy
    @topic = ForumTopic.find(params[:delete_topic])
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to @topic.forum, notice: t('messages.notice.destroy_topic.success') }
      format.json { render json: { success: true } }
    end
  end

  private

  def check_rights
    unless current_user && (current_user.is_in?([:admin, :master]) || current_user.can_moderate_forum?)
      respond_to do |format|
        format.html { render '/error_403', status: 403 }
        format.json { render json: { failure: 'Not Authorized' }, status: 403 }
      end
    end
  end

  def recalculate_posts_and_topics(from_forum, to_forum)
    Forum.where(id: [from_forum, to_forum]).each &:recalculate_ancestry
  end
end
