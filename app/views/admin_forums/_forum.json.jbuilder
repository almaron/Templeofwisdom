json.(forum, :id, :name, :hidden, :technical, :is_category, :description)
json.image forum.image_url if forum.image?
json.isCategory forum.is_category > 0
if forum.is_category
  json.children forum.children do |child|
    json.partial! "forum", forum: child
  end
end
