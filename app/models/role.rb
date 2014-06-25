class Role < ActiveRecord::Base

  validates_presence_of :head, :paths

  attr_accessor :paths

  has_many :char_roles, dependent: :destroy
  accepts_nested_attributes_for :char_roles, allow_destroy: true


  attr_accessor :comment

  before_save :parse_paths

  def parse_paths
    self.topic_ids = self.paths.scan(/\/t\/(\d+)/).map {|item| item[0].to_i}.join(',')
  end

  after_initialize :set_paths

  def set_paths
    unless self.new_record?
      self.paths = I18n.t('role.paths.dafault')
    end
  end

  def all_posts
    self.topic_ids.split(',').inject([]) { |posts, topic_id| posts + ForumPost.where(topic_id:topic_id) }
  end

  def create_post(user)
    Forum.add_role_check_post(self, user)
  end

  def self.build_from_app

  end


end
