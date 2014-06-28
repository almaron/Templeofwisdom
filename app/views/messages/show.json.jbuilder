json.(@message, :id, :head, :receive_list)
json.author @message.char.name
json.createdAt I18n.l @message.created_at, format: :full
json.content @message.text.bbcode_to_html_with_formatting