class MasterAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, class_name: MasterQuestion
end
