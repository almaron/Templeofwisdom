class ForumPostDraft < ActiveRecord::Base

  belongs_to :user
  belongs_to :topic, class_name: ForumTopic

  belongs_to :char
  belongs_to :avatar

  attr_accessor :head, :forum_id

  validates_presence_of :user_id, :char_id, :topic_id, :text

  def self.kill(topic_id, user)
    self.find_by(topic_id: topic_id, user_id: user.id).try(:delete)
  end

  def self.build_from(params)
    if params[:text].present? && params[:topic_id].present? && params[:user_id].present?
      self.find_by(topic_id: params[:topic_id], user_id: params[:user_id]).try(:delete)
      self.new params
    else
      self.new
    end
  end

  def to_post
    {
      char_id: char_id,
      avatar_id: avatar_id,
      text: text
    }
  end


end
