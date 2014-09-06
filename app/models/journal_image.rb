class JournalImage < ActiveRecord::Base

  belongs_to :page, class_name: JournalPage

  mount_uploader :image, JournalImageUploader

  validates_presence_of :image

  def remote_url=(url)
    url=="!!!" ? self.destroy : self.remote_image_url = url
  end
end
