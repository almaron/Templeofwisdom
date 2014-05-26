json.(news, :id, :head, :text, :author)
json.content simple_format(news.text)
json.dateLine I18n.l(news.created_at)