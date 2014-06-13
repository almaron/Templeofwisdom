json.array! @forums do |forum|
  json.partial! "forum", forum:forum
end