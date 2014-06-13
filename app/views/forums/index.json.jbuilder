json.array! @forums do |forum|
  json.partial! "forum", forum: forum
  json.children forum.children do |child|
    json.partial! "forum", forum: child
    json.children child.children do |ch|
      json.partial! "forum", forum: ch
    end
  end
end