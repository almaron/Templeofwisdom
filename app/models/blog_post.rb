class BlogPost < ActiveRecord::Base
  trimmed_fields :head, :text, :author
  has_many :comments, class_name: BlogComment, dependent: :destroy
  default_scope {order(created_at: :desc)}
end
