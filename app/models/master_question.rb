class MasterQuestion < ActiveRecord::Base
  belongs_to :user
  has_many :answers, class_name: MasterAnswer, foreign_key: :question_id, dependent: :delete_all

  STATUSES = %w( closed open master_answered user_answered self_answered )

  def status
    STATUSES[status_id] || 'closed'
  end

  default_scope -> { order(updated_at: :desc) }
end
