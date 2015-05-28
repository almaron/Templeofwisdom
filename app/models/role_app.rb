class RoleApp < ActiveRecord::Base

  belongs_to :user

  attr_accessor :char_id

  validates_presence_of :head, :paths

  after_update :update_post

  def create_post(user)
    self.update(post_id: role_post(user).create)
  end

  def update_post
    role_post.update
  end

  def destroy_post
    role_post.destroy
  end

  private

  def role_post(user=nil)
    SystemPosts::RoleAppPost.new(user, self)
  end

end
