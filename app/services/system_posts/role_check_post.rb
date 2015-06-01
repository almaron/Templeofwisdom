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
        ip: user.current_ip
      }
    end

    def post_locals
      { role:role, params: params }
    end

    def slug
      'role_check_post'
    end
  end
end