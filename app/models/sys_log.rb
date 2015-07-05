class SysLog < ActiveRecord::Base
  belongs_to :log_type
  default_scope -> { order(created_at: :desc) }
end
