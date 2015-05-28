module SystemPosts
  class RoleCheckPost < SystemPost
    attr_accessor :role, :params

    def initialize(user=nil, role, params)
      @user = user
      @role = role
      @params = params
    end

    private

    def post_params
      {
        topic_id: admin_config('roles_apps_topic_id'),
        char_id: admin_config('role_master_id'),
        avatar_id: default_avatar_for(admin_config('role_master_id')),
        user_id: user.id,
        ip: user.current_ip,
        text: render(partial:'shared/system_posts/role_check_post', locals:{role:role, params: params})
      }
    end
  end
end