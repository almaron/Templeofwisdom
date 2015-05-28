module SystemPosts
  class CharApprovePost < SystemPost
    attr_accessor :char

    def initialize(user = nil, char)
      @user = user
      @char = char
    end

    private

    def post_params
      return {} unless char.profile_topic_id
      {
        topic_id: char.profile_topic_id,
        char_id: admin_config('approve_master_id'),
        avatar_id: default_avatar_for(admin_config('approve_master_id')),
        user_id: user.id,
        ip: user.current_ip,
        text: I18n.t("messages.char.approve")
      }
    end
  end
end