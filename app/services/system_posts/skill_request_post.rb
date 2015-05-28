module SystemPosts
  class SkillRequestPost < SystemPost
    attr_accessible :request

    def initialize(user = nil, request)
      @user = user
      @request = request
    end

    private

    def post_params
      {
        topic_id: admin_config('skill_requests_topic_id'),
        char_id: request.char_id,
        user_id: user.id,
        ip: user.current_ip,
        text: render(partial: 'shared/system_posts/skill_request_post', locals: { request: request })
      }
    end

  end
end
