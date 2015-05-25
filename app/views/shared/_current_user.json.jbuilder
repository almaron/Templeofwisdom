json.(user, :id, :name, :group, :email)
json.messagesCount user.unread_messages_count
json.notificationsCount user.unread_notifications_count
json.default_char user.default_char ? user.default_char : Char.new
json.activeChars user.chars.where(status_id:5) do |char|
  json.(char, :id, :name)
end
json.chars user.own_chars do |char|
  json.(char, :id, :name)
end
