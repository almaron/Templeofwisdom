class Char < ActiveRecord::Base

  validates :name, :uniqueness => true, :presence => true

  belongs_to :group, :class_name => CharGroup
  belongs_to :status, :class_name => CharStatus

  has_one :profile, class_name: CharProfile, dependent: :destroy
  accepts_nested_attributes_for :profile

  mount_uploader :avatar, AvatarUploader

  scope :active, ->{where(status_id:5)}

  has_many :char_delegations
  has_many :users, :through => :char_delegations

  def delegate_to(user, options={})
    user_id = user.is_a?(User) ? user.id : user
    @cd = self.char_delegations.find_or_initialize_by(:user_id => user_id)
    options.each_pair { |option, value| @cd.send(:"#{option}=", value) }
    @cd.save
  end

  def undelegate(user)
    user_id = user.is_a?(User) ? user.id : user
    self.char_delegations.find_by(:user_id => user_id).destroy
  end

  def owned_by
    self.users.where(char_delegations: {owner:1}).first
  end
  alias_method :owner, :owned_by

  def delegated_to
    self.users.where(char_delegations: {owner:0})
  end

  def delegated_to?(user)
    user_id = user.is_a?(User) ? user.id : user
    self.char_delegations.where(user_id:user_id).any?
  end

  has_many :char_skills, dependent: :destroy
  has_many :skills, through: :char_skills
  accepts_nested_attributes_for :char_skills

  def phisic_skills
    self.char_skills.phisic
  end

  def magic_skills
    self.char_skills.magic
  end

# Delegates the created char to a user, mentioned as :creator. Don't forget to set it in the controller
  after_create :delegate_to_creator
  attr_accessor :creator

  has_many :posts, class_name: ForumPost

  # Char admin methods

  def accept(user=nil)
    if self.status_id == 2
      self.group_id == 1 ? self.update(status_id:5): self.update(status_id: 3, profile_topic_id: create_profile_topic(user))
      #   TODO send notification and email
    end
  end

  def approve(user=nil)
    if self.status_id == 3
      self.update(status_id: 5)
      #   TODO send notification and email
    end
  end

  def decline

  end

  private

  def delegate_to_creator
    if self.creator
      self.creator.default_char ? self.delegate_to(self.creator, owner:1) : self.delegate_to(self.creator, owner:1, default:1)
    end
  end

  def create_profile_topic(user)
    topic = ForumTopic.create accept_post_params(user)
    topic.id
  end

  def get_char_forum_id
    AdminConfig.find_by(name: "char_profile_forum_id_#{self.group_id}").value.to_i
  end

  def get_accept_master_id
    AdminConfig.find_by(name: 'accept_master_id').value.to_i
  end

  def accept_post_params(user)
    {
        head: self.name,
        forum_id: get_char_forum_id,
        char_id: self.id,
        posts_attributes: [
            {
                char_id: get_accept_master_id,
                user_id: user.id,
                ip: user.current_ip,
                text: render_to_string(partial: 'admin_chars/posts/profile_post')
            }
        ]
    }
  end

end
