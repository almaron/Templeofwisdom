class MailingLetter < ActiveRecord::Base
  after_create :send_mail
  belongs_to :user

  validates_presence_of :subject, :text
  default_scope -> { order(created_at: :desc) }

  def send_mail
    MailingWorker.perform_async self.id
  end
end
