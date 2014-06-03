json.phisic_skills Skill.phisic do |skill|
  json.(skill, :id, :name)
end

json.magic_skills Skill.magic do |skill|
  json.(skill, :id, :name)
end

json.levels Level.all do |level|
  json.(level, :id, :name)
end

json.accessible_groups @access_groups do |group|
  json.id group.id
  json.name I18n.t("char_groups.names.#{group.name}")
end