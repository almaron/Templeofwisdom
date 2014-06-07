class ForumTopic < ActiveRecord::Base

  has_many :posts, class_name: ForumPost
  belongs_to :forum

end
