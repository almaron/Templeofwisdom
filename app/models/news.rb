class News < ActiveRecord::Base

  validates :head, :presence => true,
            :length => {minimum: 8}

  validates :text, :presence => true,
            :length => {minimum: 15}

  default_scope { order(created_at: :desc) }

end
