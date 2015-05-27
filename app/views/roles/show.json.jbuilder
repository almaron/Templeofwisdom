json.role do
  json.(@role, :id, :head, :paths)
  json.char_roles_attributes @role.char_roles do |char_role|
    json.(char_role, :id, :char_id, :points, :logic_points, :style_points, :skill_points, :volume_points)
    json.char_name char_role.char.name
    json.skills_list char_role.role_skills.map {|rs| rs.skill.name}.join(', ')
    json._destroy 0

    json.role_skills_attributes char_role.role_skills do |role_skill|
      json.(role_skill, :id, :skill_id, :done)
      json._destroy 0
      json.skill_name role_skill.skill.name
    end
  end
end

