class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates_confirmation_of :password, :if => :password, message: I18n.t("activerecord.errors.models.user.attributes.password.confirmation")
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :email => true

  has_one :profile, class_name: UserProfile, dependent: :destroy
  accepts_nested_attributes_for :profile
  after_create {self.create_profile}

  def is_in?(*groups)
    groups.include? self.group.to_sym
  end

  has_many :char_delegations
  has_many :chars, :through => :char_delegations

  def default_char=(char)
    char_id = char.is_a?(Char) ? char.id : char
    if cd = self.char_delegations.where(owner:1, char_id:char_id)
      self.char_delegations.update_all(default:nil)
      cd.first.update(default:1)
    end
  end

  def default_char
    self.chars.where(char_delegations: {owner:1, default:1}).first
  end

  def own_chars
    self.chars.where(char_delegations: {owner:1})
  end

  def delegated_chars
    self.chars.where(char_delegations: {owner:0})
  end

end
