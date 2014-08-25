class Char < ActiveRecord::Base

  validates :name, :uniqueness => true, :presence => true

  belongs_to :group, :class_name => CharGroup
  belongs_to :status, :class_name => CharStatus

  has_one :profile, class_name: CharProfile, dependent: :destroy
  accepts_nested_attributes_for :profile

  after_create { self.create_profile }

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
  has_many :skills, through: :char_skills, dependent: :destroy
  accepts_nested_attributes_for :char_skills, allow_destroy: true

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
      self.group_id == 1 ? self.update(status_id:5): self.update(status_id: 3, profile_topic_id: ForumService.new.create_char_profile_topic(self, user))
      NoteService.new.notify_char_accept self
      #   TODO send notification and email
      true
    end
  end

  def approve(user=nil)
    if self.status_id == 3
      self.update(status_id: 5)
      ForumService.new.add_approve_post self, user
      NoteService.new.notify_char_approve self
      #   TODO send  email
    end
  end

  def decline
    if self.status_id == 2
      self.destroy
      NoteService.new.notify_char_decline self
    #  TODO send  email
    end
  end

  def remove
    self.posts.any? ? self.update(status_id:0) : self.destroy;
  end

  # Char roles

  has_many :char_roles, dependent: :destroy
  has_many :role_skills, :through => :char_roles

  #Skill Requests

  def has_enough_points?(amount)
    self.profile.points >= amount
  end

  def has_enough_role_skills?(skill_id, amount)
    role_skills.where(skill_id:skill_id, done:0).count >= amount
  end

  def add_points(amount)
    profile.update(points: profile.points+amount)
  end

  def remove_points(amount)
    profile.update(points: profile.points-amount)
  end

  def master_skills
    skills.where("level_id >= ?", 5)
  end

  def master_skill_ids
    master_skills.map {|skill| skill.id}
  end

  protected

  def delegate_to_creator
    if creator
      creator.default_char ? delegate_to(creator, owner:1) : delegate_to(creator, owner:1, default:1)
    end
  end





end
