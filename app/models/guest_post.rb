class GuestPost < ActiveRecord::Base

  validates_presence_of :head, :content, :user

  attr_accessor :captcha, :valid_captcha

  after_initialize :set_captcha

  validates :captcha, with: :validate_captcha

  def validate_captcha
    BCrypt::Password.new(@valid_captcha) == @captcha
  end

  def write_captcha
    @captcha.split(//).join(' ')
  end

  private

  def set_captcha
    self.captcha = generate_captcha 6+rand(2)
    self.valid_captcha = BCrypt::Password.create(@captcha).to_s
  end

  def generate_captcha(length)
    o = [('a'..'z'), ('A'..'Z'),('0'..'9')].map { |i| i.to_a }.flatten
    string = (0...length).map { o[rand(o.length)] }.join
  end

end
