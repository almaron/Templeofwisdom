require 'render_anywhere'
class ForumService
  include RenderAnywhere

  def initialize(user=nil)
    @user = user
  end
  # System forum topics and system_posts creation


  def create_skill_request_post(request)
    post = ForumPost.create topic_id: admin_config('skill_requests_topic_id'), char_id: request.char_id, user_id: @user.id, ip: @user.current_ip, text: render(partial: 'shared/system_posts/skill_request_post', locals: {request: request})
    post.id if post
  end

  private

  def admin_config(config)
    AdminConfig.find_by(name:config).value.to_i
  end


  def default_avatar_for(char_id)
    CharAvatar.find_by(char_id: char_id, default: true).try(:id)
  end


end