if params[:short]
  json.(@char, :id, :name)
  json.profile_attributes do
    json.season_id @char.profile.season_id
    json.birth_date @char.profile.birth_date
  end
else
  json.(@char, :id, :name, :status_line, :status_id, :open_player)
  json.avatar @char.avatar_url(:thumb) if @char.avatar?
  json.profile do
    json.(@char.profile, :real_age, :birth_date, :place, :beast, :person, :points)
    %w(phisics bio character items other comment).each do |field|
      json.set! field, @char.profile.send(field)
    end
  end
end

if current_user.is_in? [:admins] || @char.open_player
  json.owner do
    json.(@char.owned_by, :id, :name)
  end
end


json.phisic_skills @char.phisic_skills do |skill|
  json.skill_id skill.skill_id
  json.level_id skill.level_id
  json.skill_name skill.skill.name
  json.level_name skill.level.name
end

json.magic_skills @char.magic_skills do |skill|
  json.skill_id skill.skill_id
  json.level_id skill.level_id
  json.skill_name skill.skill.name
  json.level_name skill.level.name
end