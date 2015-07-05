class CharAvatar < ActiveRecord::Base

  belongs_to :char
  has_many :forum_posts, foreign_key: :avatar_id

  mount_uploader :image, AvatarUploader

  after_destroy :set_default_destroy
  before_create :set_default_create

  validates_presence_of :image
  before_destroy :remove_file

  scope :visible, -> { where(visible: true) }

  def set_default_destroy
    self.class.where(char_id: self.char_id).last.update(default: true) if default? if self.class.where(char_id: self.char_id).last
  end

  def set_default_create
    set_default if self.class.where(char_id: self.char_id, default: true).empty? || self.default?
  end

  def set_default_avatar
    set_default.save
  end

  def set_default
    self.class.where(char_id: self.char_id).update_all(default: false)
    self.default = true
    self
  end

  def remove_file
    remove_image!
  end

end
