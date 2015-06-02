require 'render_anywhere'
module SystemPosts
  class SystemPost
    include RenderAnywhere

    attr_accessor :user

    def create
      ForumPost.create(params.permit!).try(:id)
    end

    private

    def params
      post_params.merge({ text: render(render_params) })
    end

    def render_params
      {
        partial: "/shared/system_posts/#{slug}",
        locals: post_locals
      }
    end

    def post_locals
      {}
    end

    def admin_config(config)
      AdminConfig.find_by(name:config).value.to_i
    end

    def default_avatar_for(char_id)
      CharAvatar.find_by(char_id: char_id, default: true).try(:id)
    end

    def slug
      ''
    end
  end
end