class MasterNotificationsController < ApplicationController
  before_action :require_login

  def create
    Notes::PostMaster.new.create topic, post, params[:comment]
    respond_to do |format|
      format.html { redirect_to forum_topic_path(topic.forum_id, topic.id) }
      format.json { render json: { success: true } }
    end
  end

  private

  def topic
    @topic ||= ForumTopic.find params[:topic_id]
  end

  def post
    @post ||= ForumPost.find params[:post_id]
  end
end
