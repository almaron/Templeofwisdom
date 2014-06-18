json.(@char, :id, :name, :group_id, :status_id, :status_line)
json.avatar_img image_tag(@char.avatar_url(:thumb)) if @char.avatar?
json.profile do
  json.(@char.profile, :birth_date, :real_age, :place, :beast, :phisics, :items, :bio, :look, :character, :person, :other, :comment, :points)
end