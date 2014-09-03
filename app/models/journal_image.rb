class JournalImage < ActiveRecord::Base

  belongs_to :page, class_name: JournalPage

  mount_uploader :image, JournalImageUploader
end
