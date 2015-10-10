class NewsParser
  attr_reader :news

  def initialize(news)
    @news = news
  end

  def parse
    PARSERS.each do |parser|
      news.text = news.text.gsub(parser[0], parser[1])
    end
    news.save
  end

  private

  PARSERS = [
    [/<a href=["'](.+?)["'].*?>(.*?)<\/a>/m, '[url=\1]\2[/url]'],
    [/<img.*?src=["'](.*?)["'].*?\/?>/m, '[img]\1[/img]'],
    [/<div.*?align=['"](.*?)['"].*?>(.*?)<\/div>/m, '[\1]\2[/\1]'],
    [/<div.*?>(.*?)<\/div>/m, '\1']
  ]
end
