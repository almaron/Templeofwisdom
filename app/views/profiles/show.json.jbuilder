json.(@user, :id, :name, :email, :group)
json.profile_attributes do
  json.extract! @user.profile, :full_name, :icq, :skype, :contacts, :viewcontacts
  json.birth_date I18n.l(@user.profile.birth_date) if @user.profile.birth_date
end

json.authentications @user.authentications.map { |auth| auth.provider }

json.own_chars @user.own_chars do |char|
  json.id char.id
  json.name char.name
  json.char_url "char_path(char)#{char.id}"
  json.regDate I18n.l(char.created_at)
  json.status I18n.t "char_status.name.#{char.status.name}"
  json.status_class char.statis.name

  json.delegated_to char.char_delegations.delegated.all.to_a do |delegation|
    json.id delegation.id
    json.username delegation.user.name
  end
end

json.delegated_chars @user.char_delegations.delegated.all.to_a do |delegation|
  json.extract! delegation.char, :id, :name
  json.char_url "char_path(char)#{delegation.char_id}"
  json.owner_name delegation.char.owner.name
  json.end_date delegation.ending ? I18n.l(delegation.ending) : I18n.t("char_delegation.ending_nil")
end