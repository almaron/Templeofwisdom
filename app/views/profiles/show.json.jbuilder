json.user do
  json.partial! "user", user: @user
end

json.authentications @user.authentications.map { |auth| auth.provider }

json.own_chars @user.own_chars do |char|
  json.id char.id
  json.name char.name
  json.char_url "char_path(char)#{char.id}"
  json.regDate I18n.l(char.created_at)
  json.status I18n.t "char_status.name.#{char.status.name}"
  json.status_class char.status.name

  json.delegated_to char.char_delegations.delegated.all.to_a do |delegation|
    json.partial! 'delegations/delegation', delegation: delegation
  end
end

json.delegated_chars @user.char_delegations.delegated.all.to_a do |delegation|
  json.extract! delegation.char, :id, :name
  json.char_url "char_path(char)#{delegation.char_id}"
  json.owner_id delegation.char.owned_by.id
  json.owner_name delegation.char.owned_by.name
  json.end_date delegation.ending ? I18n.l(delegation.ending) : I18n.t("char_delegation.ending_nil")
end