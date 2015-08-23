class Role < ActiveRecord::Base

  validates_presence_of :head, :paths

  attr_accessor :paths, :comment, :role_app_id, :char_posts

  has_many :char_roles, dependent: :destroy
  accepts_nested_attributes_for :char_roles, allow_destroy: true

  before_save :parse_paths

  after_create :destroy_app
  after_create :close_topics
  after_initialize :set_paths

  def self.build_from_app(app_id=nil)
    return new unless app_id
    role_app = RoleApp.find(app_id)
    role = self.new(head:role_app.head, paths:role_app.paths, comment: role_app.comment)
    role.parse_paths.collect_char_posts.build_char_roles
  end

  def all_posts
    @posts ||= ForumPost.where(topic_id: topic_ids.split(','))
  end

  def order_posts
    self.topic_ids.split(',').inject([]) { |posts, topic_id| posts + ForumPost.where(topic_id: topic_id) }
  end

  def parse_paths
    self.topic_ids = paths.scan(/\/t\/(\d+)/).map {|item| item[0].to_i}.join(',')
    self.char_roles.each { |ch| ch.points_will_change! }
    self
  end

  def set_paths
    self.paths = topic_ids.split(',').map {|id| "/temple/t/#{id}"}.join("\n") if topic_ids.present?
  end

  def collect_char_posts
    posts = self.char_posts = {}
    all_posts.each do |post|
      cid = "ch#{post.char_id}"
      posts[cid] ||= 0
      posts[cid] += post.text.length
    end
    posts.keys.each { |key| self.char_posts[key] = (posts[key].to_f / 600).round }
    self
  end

  def build_char_roles
    get_chars_from_posts.each do |char|
      self.char_roles.build char_id:char, post_count: char_posts["ch#{char}"]
    end
    self
  end

  private

  def get_chars_from_posts
    @chars ||= all_char_ids.select do |char_id|
      char = get_char(char_id)
      (2..4).include?(char.group_id) && char.status_id == 5
    end
  end

  def destroy_app
    RoleApp.find(self.role_app_id).destroy if self.role_app_id
  end

  def all_char_ids
    all_posts.pluck(:char_id).uniq
  end

  def get_char(id)
    @char ||= []
    @char[id] ||= Char.find(id)
  end

  def close_topics
    ForumTopic.where('id IN (?)', topic_ids).update_all closed: true
  end
end
