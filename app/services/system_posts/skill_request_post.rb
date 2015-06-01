module SystemPosts
  class SkillRequestPost < SystemPost
    attr_accessor :request

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
        avatar_id: default_avatar_for(request.char_id),
        ip: user.current_ip
      }
    end

    def post_locals
      { request: request }
    end

    def slug
      'skill_request_post'
    end
  end
end
