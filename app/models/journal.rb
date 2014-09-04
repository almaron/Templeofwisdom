class Journal < ActiveRecord::Base

  has_many :pages, class_name: JournalPage

  after_initialize :set_default
  mount_uploader :cover, CoverUploader

  scope :published, -> {where('publish_date <= ?', DateTime.now)}

  private

  def set_default
    self.head ||= "Journal"
    self.publish_date ||= DateTime.now
  end


end
