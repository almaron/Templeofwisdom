module SystemPosts
  class RoleAppPost < SystemPost
    attr_accessor :app

    def initialize(user=nil, role_app)
      @user = user
      @app = role_app
    end

    def update
      post.update text: render(partial:'shared/system_posts/role_app', locals: { role_app:app })
    end

    def destroy
      post.destroy if app.post_id && post
    end

    private

    def post_params
      {
        topic_id: admin_config('roles_apps_topic_id'),
        char_id: app.char_id,
        avatar_id: default_avatar_for(app.char_id),
        user_id: user.id,
        ip: user.current_ip,
        text: render(partial:'shared/system_posts/role_app', locals: { role_app: app })
      }
    end

    def post
      @post ||= ForumPost.find app.post_id
    end
  end
end