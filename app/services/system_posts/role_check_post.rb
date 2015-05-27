module SystemPosts
  class RoleCheckPost < SystemPost
    attr_accessor :role

    def initialize(user=nil, role)
      @user = user
      @role = role
    end

    private

    def post_params
      byebug
      {
        topic_id: admin_config('roles_apps_topic_id'),
        char_id: admin_config('role_master_id'),
        avatar_id: default_avatar_for(admin_config('role_master_id')),
        user_id: user.id,
        ip: user.current_ip,
        text: render(partial:'shared/system_posts/role_check_post', locals:{role:role})
      }
    end
  end
end