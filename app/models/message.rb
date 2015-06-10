class Message < ActiveRecord::Base

  validates_presence_of :char_id, :user_id, :head, :text

  belongs_to :char
  belongs_to :user

  has_many :receivers, class_name: MessageReceiver
  has_many :chars, through: :receivers
  attr_accessor :reply_ids

  before_create :set_receive_list

  attr_accessor :read

  def destruct
    self.receivers.any? ? self.update(deleted:1) : self.destroy
  end

  def remove_receiver
    self.destroy if self.receivers.empty? && self.deleted?
  end

  def set_receive_list
    self.receive_list = self.chars.collect {|char| char.name}.join(', ')
  end

  def self.reply(msg)
    message = msg.is_a?(Message) ? msg : self.find(msg)
    mess = self.new head:"Re: "+message.head, text: reply_quote(message), reply_ids:[message.char_id]
  end

  def self.reply_quote(msg)
    "\n\n[reply=#{I18n.l(msg.created_at, format: :full)} | #{msg.char.name}]#{msg.text}[/reply]"
  end

end
