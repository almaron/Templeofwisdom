json.(user, :id, :name, :email)
json.state I18n.t("users.state.#{user.activation_state}")
json.group I18n.t("users.groups.#{user.group}")

json.chars user.own_chars