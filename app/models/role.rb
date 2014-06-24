class Role < ActiveRecord::Base

  validates_presence_of :head, :paths

  has_many :char_roles, dependent: :destroy
  accepts_nested_attributes_for :char_roles, allow_destroy: true

  def head_url
    self.paths.split(/\r?\n/).reject {|l| l.strip.empty?}[0]
  end

  attr_accessor :comment

  before_save :parse_paths

  def parse_paths
    self.topic_ids = self.paths.scan(/\/t\/(\d+)/).map {|item| item[0].to_i}.join(',')
  end

  def full_topics
    self.topic_ids.split(',').inject([]) { |posts, topic_id| posts + ForumPost.where(topic_id:topic_id) }
  end


end
