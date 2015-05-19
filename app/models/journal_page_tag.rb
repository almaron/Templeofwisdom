class JournalPageTag < ActiveRecord::Base

belongs_to :page, class_name: JournalPage
belongs_to :tag,  class_name: JournalTag

end
