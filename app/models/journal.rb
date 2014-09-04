class Journal < ActiveRecord::Base

  has_many :pages, class_name: JournalPage

  after_initialize :set_default
  mount_uploader :cover, CoverUploader

  scope :published, -> {where(published: true)}

  private

  def set_default
    self.head ||= "Journal #{self.class.get_new_id}"
  end

  def self.get_new_id
    self.last.nil? ? 1 : self.last.id+1
  end


end
