require 'render_anywhere'
class ForumService
  include RenderAnywhere

  # System forum topics and system_posts creation

  def create_char_profile_topic(char, user)
    topic = ForumTopic.create char_profile_topic_params(char, user)
    topic.id if topic
  end

  def add_approve_post(char,user)
    ForumPost.create topic_id: char.profile_topic_id, char_id: admin_config('approve_master_id'), user_id: user.id, ip: user.current_ip, text: I18n.t("messages.char.approve")
  end

  def add_role_check_post(role, user)
    ForumPost.create topic_id: admin_config('roles_apps_topic_id'), char_id: admin_config('role_master_id'), user_id: user.id, ip: user.current_ip, text: render(partial:'forums/system_posts/role_check_post', locals:{role:role})
  end

  def create_role_app_post(role_app, user)
    post = ForumPost.create topic_id: admin_config('roles_apps_topic_id'), char_id: role_app.char_id, user_id: user.id, ip: user.current_ip, text: render(partial:'forums/system_posts/role_app', locals:{role_app:role_app})
    post.id if post
  end

  def update_role_app_post(role_app)
    ForumPost.find(role_app.post_id).update(text: render(partial:'forums/system_posts/role_app', locals:{role_app:role_app}))
  end

  private

  def char_profile_topic_params(char, user)
    {
        head: char.name,
        forum_id: admin_config('char_profile_forum_id_'+char.group_id.to_s),
        char_id: char.id,
        poster_name: get_accept_master.name,
        posts_attributes: [
            {
                char_id: get_accept_master.id,
                user_id: user.id,
                ip: user.current_ip,
                text: render(partial: 'forums/system_posts/profile_post', locals:{char:char})
            }
        ]
    }
  end

  def admin_config(config)
    AdminConfig.find_by(name:config).value.to_i
  end

  def get_accept_master
    Char.find_by(id: admin_config('accept_master_id')) || Char.new(name:"Master")
  end

end