class NewsController < ApplicationController

  before_action :get_news, only: [:show, :edit, :update, :destroy]

  def index
    nt = params[:limit] || app_configs[:news_per_page] || 5
    @news = News.paginate(:page => params[:page], :per_page => nt)
    #raise _layout.inspect
  end

  def show
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    respond_to do |format|
      if @news.save
        format.html { redirect_to news_path(@news) }
        format.json { render partial: "news", locals: {news: @news} }
      else
        format.html {render :new}
        format.json {render json: nil}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html {redirect_to news_path(@news)}
        format.json { render partial: "news", locals: {news: @news} }
      else
        format.html { render :edit }
        format.json { render json: nil }
      end
    end
  end

  def destroy
    @news.destroy
    respond_to do |f|
      f.html { redirect_to news_index_path }
      f.js   { render js: "$('#news_id#{@news.id}').remove();" }
      f.json {render :json => nil}
    end
  end

  private

  def get_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:author,:head,:text)
  end

end
