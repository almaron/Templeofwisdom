json.(user, :id, :name, :group, :email)
json.default_char user.default_char ? user.default_char : Char.new
