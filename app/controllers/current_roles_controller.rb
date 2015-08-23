class CurrentRolesController < ApplicationController
  before_action :require_login

  def index
    if current_user.char_ids.any?
      @topics = ForumTopic.includes(:posts)
        .where(closed: false, forum_id: forum_ids, forum_posts: {char_id: char_ids})
        .group('forum_topics.id').order(last_post_at: :desc)
        .paginate(page: params[:page], per_page: 25)
    else
      redirect_to profile_path, alert: t('messages.alert.current_roles.nochar')
    end
  end

  private

  def char_ids
    current_user.chars.where('group_id > 1').pluck :id
  end

  def forum_ids
    Forum.find(1).subtree_ids
  end

end


