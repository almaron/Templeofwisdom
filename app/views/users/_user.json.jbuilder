json.(user, :id, :name, :email, :group)
json.state I18n.t("users.state.#{user.activation_state}")
json.group_name I18n.t("users.groups.#{user.group}")

json.cancans do
  json.view_hidden user.cancans[:view_hidden]
  json.moderate_forum user.cancans[:moderate_forum]
end

json.chars user.own_chars do |char|
  json.(char, :id, :name, :status_id)
end

json.delegated_chars user.delegated_chars do |char|
  json.(char, :id, :name, :status_id)
end

json.profile_attributes do
  json.(user.profile, :full_name, :icq, :skype, :contacts)
  json.birth_date I18n.l(user.profile.birth_date) if user.profile.birth_date
end