class Forum < ActiveRecord::Base

  has_ancestry

  has_many :topics, class_name: ForumTopic
end
