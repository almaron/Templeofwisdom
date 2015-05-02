json.(@char, :id, :name, :group_id, :status_id, :status_line)
json.avatar_img image_tag(@char.avatar_url(:thumb)) if @char.avatar?
json.avatar_url @char.avatar_url(:thumb) if @char.avatar?
json.group_name I18n.t("char_groups.names.#{@char.group.name}")

if @char.profile do
  json.profile_attributes do
    json.(@char.profile, :birth_date, :real_age, :place, :beast, :phisics, :items, :bio, :look, :character, :person, :other, :comment, :points)
  end
end

json.magic_skills @char.magic_skills.eager_load(:skill, :level) do |ch|
  json.(ch, :skill_id, :level_id)
  json.skill_name ch.skill.name
  json.level_name ch.level.name
end

json.phisic_skills @char.phisic_skills.eager_load(:skill, :level) do |ch|
  json.(ch, :skill_id, :level_id)
  json.skill_name ch.skill.name
  json.level_name ch.level.name
end