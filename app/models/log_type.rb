class LogType < ActiveRecord::Base
  has_ancestry
  has_many :sys_logs
end
