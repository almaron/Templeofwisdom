class JournalBlock < ActiveRecord::Base

  belongs_to :page, class_name: JournalPage

  validates_presence_of :content

  mount_uploader :image, JournalImageUploader

  after_initialize :set_default_content

  def remote_url=(url)
    url=="!!!" ? self.remove_image = true : self.remote_image_url = url
  end

  private

  def set_default_content
    self.content ||= ""
  end

end
