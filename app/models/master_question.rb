class MasterQuestion < ActiveRecord::Base
  belongs_to :user
  has_many :answers, class_name: MasterAnswer, foreign_key: :question_id

  STATUSES = [
    nil,
    :open,
    :master_answered,
    :user_answered,
    :self_answered,
    :closed
  ]

  def status
    STATUSES[status_id]
  end
end
