json.array! @forums do |forum|
  json.partial! "forum", forum: forum
  json.children forum.visible_children(current_user) do |child|
    json.partial! "forum", forum: child
    json.children child.visible_children(current_user) do |ch|
      json.partial! "forum", forum: ch
    end
  end
end