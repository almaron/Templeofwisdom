class ForumTopicDraft < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum

  validates_presence_of :user_id, :forum_id, :text, :char_id, :avatar_id

  attr_accessor :topic_id

  def build_from(params)
    if params[:text].present? && params[:forum_id].present? && params[:user_id].present?
      find_by(forum_id: params[:forum_id], user_id: params[:user_id]).try(:delete)
      new params
    else
      new
    end
  end

  def to_topic
    {
      head: head,
      forum_id: forum_id
    }
  end

  def to_post
    {
      text: text,
      char_id: char_id,
      avatar_id: avatar_id
    }
  end

end
