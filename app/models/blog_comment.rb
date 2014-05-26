class BlogComment < ActiveRecord::Base
  belongs_to :blog_post
  belongs_to :user

  def author_name
    self.user ? self.user.name : self.author
  end

end
