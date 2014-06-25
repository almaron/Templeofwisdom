class MessageReceiver < ActiveRecord::Base

  belongs_to :message
  belongs_to :char
  belongs_to :user

  before_save :set_user

  def set_user
    self.user_id = CharDelegation.find_by(char_id:self.char_id, owner:1).try(:user_id)
  end

  after_destroy :message_remove_receiver
  def message_remove_receiver
    self.message.remove_receiver
  end

end
