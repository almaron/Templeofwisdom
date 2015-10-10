json.(news, :id, :head, :text, :author)
json.content temple_format(news.text.bbcode_to_html)
json.dateLine I18n.l(news.created_at)
