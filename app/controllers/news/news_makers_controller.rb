class News::NewsMakersController < ApplicationController
  def create
    @news = NewsMaker.new news_params
    render json: @news.to_json
  end

  private

  def news_params
    params.require(:news).permit(:text, :head)
  end
end
