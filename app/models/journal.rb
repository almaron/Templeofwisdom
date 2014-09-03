class Journal < ActiveRecord::Base

  has_many :pages, class_name: JournalPage

  after_initialize :set_default
  mount_uploader :cover, CoverUploader

  private

  def set_default
    self.head ||= "Journal"
    self.publish_date ||= DateTime.now
  end


end
