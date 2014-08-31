class UserIp < ActiveRecord::Base
  belongs_to :user

  validates :ip, ip: true
end
