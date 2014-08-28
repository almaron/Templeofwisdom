class RoleApp < ActiveRecord::Base

  belongs_to :user

  attr_accessor :char_id

  validates_presence_of :head, :paths

  after_destroy :destroy_post
  after_update :update_post

  def create_post(user)
    self.update(post_id: ForumService.new(user).create_role_app_post(self))
  end

  def update_post
    ForumService.new.update_role_app_post(self)
  end

  def destroy_post
    ForumPost.find_by(id:self.post_id).destroy if self.post_id
  end

end
