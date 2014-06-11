json.array! @groups do |group|
  json.name group
  json.title I18n.t("users.groups.#{group}")
end