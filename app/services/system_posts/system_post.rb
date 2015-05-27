require 'render_anywhere'
module SystemPosts
  class SystemPost
    include RenderAnywhere

    attr_accessor :user

    def create
      ForumPost.create(post_params).try(:id)
    end

    private

    def post_params
      {}
    end

    def admin_config(config)
      AdminConfig.find_by(name:config).value.to_i
    end

    def default_avatar_for(char_id)
      CharAvatar.find_by(char_id: char_id, default: true).try(:id)
    end

  end
end