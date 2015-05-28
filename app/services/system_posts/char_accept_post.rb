module SystemPosts
  class CharAcceptPost < SystemPost
    attr_accessor :char

    def initialize(user = nil, char)
      @user = user
      @char = char
    end

    def create
      ForumTopic.create(post_params).try(:id) if admin_config("char_profile_forum_id_#{char.group_id}")
    end

    private

    def post_params
      {
        head: char.name,
        forum_id: admin_config("char_profile_forum_id_#{char.group_id}"),
        char_id: accept_master.id,
        poster_name: accept_master.name,
        posts_attributes: [
            {
                char_id: accept_master.id,
                user_id: user.id,
                ip: user.current_ip,
                text: render(partial: 'shared/system_posts/profile_post', locals: { char:char })
            }
        ]
      }
    end

    def accept_master
      @master ||= Char.find_by(id: admin_config('accept_master_id')) || Char.new(name:"Master")
    end
  end
end
