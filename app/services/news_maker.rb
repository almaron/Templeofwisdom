class NewsMaker
  attr_reader :news
  include ApplicationHelper

  def initialize(params)
    @news = News.new(params)
  end

  def to_json
    {
      text: text,
      html: html
    }
  end

  def text
    clear_bbcode news_full_text
  end

  def html
    temple_format news_full_text.bbcode_to_html
  end

  private

  def news_full_text
    "#{news.head}\n\n#{news.text}"
  end

  def clear_bbcode(string)
    string.gsub(/(\[img\].*\[\/img\])/m, '').gsub(/(\[.*?\])/m,'')
  end
end
