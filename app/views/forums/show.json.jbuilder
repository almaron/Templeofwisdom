json.forum do
  json.partial! "forum", forum: @forum

  json.child_categories @forum.child_categories do |forum|
    json.partial! "forum", forum: forum
    json.children forum.children do |child|
      json.partial! "forum", forum: child
    end
  end

  json.child_forums @forum.child_forums do |forum|
    json.partial! "forum", forum: forum
  end

end

json.path @forum.path do |forum|
  json.(forum, :id, :name)
end

