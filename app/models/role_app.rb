class RoleApp < ActiveRecord::Base

  belongs_to :user

  attr_accessor :char_id

  validates_presence_of :head, :paths

  after_destroy :destroy_post
  after_update :update_post

  def create_post(user)
    self.update(post_id: SystemPosts::RoleAppPost.new(user, self).create)
  end

  def update_post
    SystemPosts::RoleAppPost.new(self).update
  end

  def destroy_post
    SystemPosts::RoleAppPost.new(self).destroy
  end

end
