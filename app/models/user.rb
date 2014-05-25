class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates_confirmation_of :password, :if => :password
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :email => true

end
