json.array! @chars do |char|
  json.(char, :id, :name, :group_id, :status_id)
  json.group_name I18n.t("char_groups.names.#{char.group.name}")
  json.status_name I18n.t("char_status.name.#{char.status.name}")
  json.avatar_img image_tag(char.avatar_url(:thumb)) if char.avatar?
  json.owner do
    json.(char.owner, :id, :name)
  end
  json.points char.profile.points
  json.createdAt I18n.l(char.created_at)

  json.delegations char.delegated_to do |user|
    json.(user, :id, :name)
  end
end