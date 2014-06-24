json.skills Skill.all do |skill|
  json.(skill, :id, :name)
end

json.chars @chars do |char|
  json.(char, :id, :name)
end