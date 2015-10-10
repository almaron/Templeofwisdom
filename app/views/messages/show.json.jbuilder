json.(@message, :id, :head, :receive_list)
json.author @message.char.name
json.createdAt I18n.l @message.created_at, format: :full
json.content temple_format(@message.text.bbcode_to_html)
