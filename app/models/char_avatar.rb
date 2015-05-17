class CharAvatar < ActiveRecord::Base

  belongs_to :char

  mount_uploader :image, AvatarUploader

  after_destroy :set_new_default
  after_create :set_new_default

  def set_default
    char.default_avatar = self
  end

  def set_new_default
    if default?
      char.set_default_avatar_last
    end
  end

end
