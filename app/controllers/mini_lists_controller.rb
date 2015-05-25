class MiniListsController < ApplicationController
  layout false

  def news
    @news = News.order(created_at: :desc).limit 4
    render params[:temp] || :news
  end

  def blog
    @posts = BlogPost.order(created_at: :desc).limit 4
  end

end
