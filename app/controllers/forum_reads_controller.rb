class ForumReadsController < ApplicationController

  def index
      forum_ids = ForumTopic.unscoped
        .select('distinct forum_id')
        .joins("LEFT JOIN forum_topic_reads ON forum_topic_reads.forum_topic_id = forum_topics.id AND forum_topic_reads.user_id = #{current_user.id}")
        .where(show_hidden, whole_read)
        .group('forum_topics.id').having('count(forum_topic_reads.id) < 1')
        .map(&:forum_id)
      full_ids = (current_user.can_view_hidden? ? forum_query(forum_ids) : forum_query(forum_ids).visible)
        .pluck(:ancestry).map {|ancestry| ancestry.split('/')}
        .flatten.map(&:to_i).uniq
    render json: full_ids+forum_ids
  end

  def show
    topic_ids = ForumTopic.unscoped
      .joins("LEFT JOIN forum_topic_reads ON forum_topic_reads.forum_topic_id = forum_topics.id AND forum_topic_reads.user_id = #{current_user.id}")
      .where(forum_id: params[:id])
      .where('forum_topics.last_post_at > ?', whole_read)
      .group('forum_topics.id').having('count(forum_topic_reads.id) < 1')
      .pluck(:id)
    render json: topic_ids
  end

  def create
    if params[:forum]
      ForumTopic.where(forum_id: params[:forum].to_i).pluck(:id).each do |id|
        ForumTopicRead.find_or_create_by user_id: current_user.id, forum_topic_id: id
      end
    else
      ForumTopicRead.find_or_create_by(user_id: current_user.id, forum_topic_id: 0).touch
    end
    render json: { success: true }
  end

  private

  def whole_read
    ForumTopicRead.find_by(user_id: current_user.id, forum_topic_id: 0).try(:updated_at) || 0
  end

  def show_hidden
    "forum_topics.last_post_at > ? #{'AND hidden = 0' unless current_user.can_view_hidden?}"
  end

  def forum_query(forum_ids)
    Forum.unscoped.where(id: forum_ids)
  end

end

# ForumTopic.unscoped.select('distinct forum_id').joins("LEFT JOIN forum_topic_reads ON forum_topic_reads.forum_topic_id = forum_topics.id AND forum_topic_reads.user_id = #{current_user.id}").group('forum_topics.id').having('count(forum_topic_reads.id) < 1').map(&:forum_id)`
