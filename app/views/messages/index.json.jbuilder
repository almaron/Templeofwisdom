json.array! @messages do |msg|
  json.(msg,:id,:head, :receive_list)
  json.author msg.char.name
  json.createdAt I18n.l(msg.created_at, format: :full)
  json.read !msg.read || msg.read > 0
end