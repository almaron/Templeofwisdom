class Role < ActiveRecord::Base

  validates_presence_of :head, :paths

  attr_accessor :paths, :comment, :role_app_id

  has_many :char_roles, dependent: :destroy
  accepts_nested_attributes_for :char_roles, allow_destroy: true

  before_save :parse_paths

  after_create :destroy_app

  def all_posts
    self.topic_ids.split(',').inject([]) { |posts, topic_id| posts + ForumPost.where(topic_id:topic_id) }
  end

  def self.build_from_app(app_id)
    role_app = RoleApp.find(app_id)
    role = self.new(head:role_app.head, paths:role_app.paths, comment: role_app.comment)
    role.get_chars_from_posts.each {|char| role.char_roles.build char_id:char  }
    role
  end

  def get_chars_from_posts
    parse_paths
    all_char_ids.select { |char_id| get_char(char_id).group_id > 1 && get_char(char_id).status_id == 5 }
  end

  private

  def parse_paths
    self.topic_ids = self.paths.scan(/\/t\/(\d+)/).map {|item| item[0].to_i}.join(',')
  end

  def destroy_app
    RoleApp.find(self.role_app_id).destroy if self.role_app_id
  end

  def all_char_ids
    ForumPost.where(topic_id: self.topic_ids.split(',')).pluck(:char_id).uniq
  end

  def get_char(id)
    @char ||= []
    @char[id] ||= Char.find(id)
  end

end
