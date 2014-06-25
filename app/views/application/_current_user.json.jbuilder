json.(user, :id, :name, :group, :email)
json.default_char user.default_char ? user.default_char : Char.new
json.activeChars user.chars.where(status_id:5) do |char|
  json.(char, :id, :name)
end
