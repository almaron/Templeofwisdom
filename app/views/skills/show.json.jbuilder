json.array! @skills do |skill|
  json.(skill, :id, :name, :skill_type)
end