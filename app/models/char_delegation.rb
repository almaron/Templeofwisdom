class CharDelegation < ActiveRecord::Base

  belongs_to :char
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :char_id

  scope :owned, -> { where(:owner => 1) }
  scope :default, -> { where(:default => 1) }
  scope :delegated, -> { where(:owner => 0) }

  def user_name
    user.try(:name)
  end

  def user_name=(name)
    self.user = User.find_by(:name => name) if name.present?
  end

end
