class Message < ActiveRecord::Base

  validates_presence_of :char_id, :user_id, :head, :text

  belongs_to :char
  belongs_to :user

  has_many :receivers, class_name: MessageReceiver
  has_many :chars, through: :receivers

  before_destroy :check_receivers


  def check_receivers
    if self.receivers.empty?
      true
    else
      self.update(deleted: 1)
      false
    end
  end

  def remove_receiver
    self.destroy if self.receivers.empty? && self.deleted?
  end

end
