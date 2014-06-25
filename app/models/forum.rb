require 'render_anywhere'
class Forum < ActiveRecord::Base

  include RenderAnywhere

  has_ancestry

  has_many :topics, class_name: ForumTopic

  default_scope {order(:sort_order)}

  def add_post(post)
    self.path.update_all({
                    last_post_id: post.id,
                    last_post_topic_id: post.topic_id,
                    last_post_char_name: post.char.name,
                    last_post_char_id: post.char_id,
                    last_post_at: post.created_at
                })
    self.path.update_all("posts_count = posts_count + 1")
  end

  def add_topic
    self.path.update_all("topics_count = topics_count + 1")
  end


  def remove_post(post)
    self.path.each { |f| f.update_last_post if post.id == f.last_post_id }
    self.path.update_all("posts_count = posts_count - 1")
  end

  def remove_topic(topic = nil)
    self.path.update_all("topics_count = topics_count - 1")
    if topic
      self.path.each { |f| f.update_last_post if topic.id == f.last_post_topic_id }
    end
  end

  def update_last_post
    last_post = ForumPost.joins(:topic).where(forum_topics: {forum_id: self.subtree_ids}).last
    if last_post
      self.update({
                    last_post_id: last_post.id,
                    last_post_topic_id: last_post.topic_id,
                    last_post_char_name: last_post.char.name,
                    last_post_char_id: last_post.char_id,
                    last_post_at: last_post.created_at
                })
    else
      self.update({
                      last_post_id: nil,
                      last_post_topic_id: nil,
                      last_post_char_name: nil,
                      last_post_char_id: nil,
                      last_post_at: nil,
                  })
    end
  end

  scope :categories, ->{where(is_category: 1)}
  scope :forums, ->{where(is_category: 0)}

  def child_categories
    self.children.categories
  end

  def child_forums
    self.children.forums
  end


  # System forum topics and system_posts creation

  def self.create_char_profile_topic(char, user)
    topic = ForumTopic.create char_profile_topic_params(char, user)
    topic.id if topic
  end

  def self.add_approve_post(char,user)
    ForumPost.create topic_id: char.profile_topic_id, char_id: admin_config('approve_master_id'), user_id: user.id, ip: user.current_ip, text: I18n.t("messages.char.approve")
  end

  def self.add_role_check_post(role, user)
    ForumPost.create topic_id: admin_config('roles_apps_topic_id'), char_id: admin_config('role_master_id'), user_id: user.id, ip: user.current_ip, text: render(partial:'forums/system_posts/role_check_post', locals:{role:role})
  end

  def self.create_role_app_post(role_app, user)
    post = ForumPost.create topic_id: admin_config('roles_apps_topic_id'), char_id: role_app.char_id, user_id: user.id, ip: user.current_ip, text: render(partial:'forums/system_posts/role_app', locals:{role_app:role_app})
    post.id if post
  end

  def self.update_role_app_post(role_app)
    ForumPost.find(role_app.post_id).update(text: render(partial:'forums/system_posts/role_app', locals:{role_app:role_app}))
  end

  private

  def self.char_profile_topic_params(char, user)
    {
        head: self.name,
        forum_id: admin_config('char_profile_forum_id_'+char.group_id.to_s),
        char_id: char.id,
        poster_name: get_accept_master.name,
        posts_attributes: [
            {
                char_id: get_accept_master.id,
                user_id: user.id,
                ip: user.current_ip,
                text: render(partial: 'forums/system_posts/profile_post', locals:{char:char})
            }
        ]
    }
  end

  def self.admin_config(config)
    AdminConfig.find_by(name:config).value.to_i
  end

  def self.get_accept_master
    Char.find_by(id: admin_config('accept_master_id')) || Char.new(name:"Master")
  end



end
