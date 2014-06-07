class ForumPost < ActiveRecord::Base

  belongs_to :topic, class_name: ForumTopic
  belongs_to :char
  belongs_to :user


end
