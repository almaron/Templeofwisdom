json.array! @notifications do |note|
  json.(note, :id, :head, :priority)
  json.createdAt I18n.l(note.created_at, format: :full)
  json.read note.read?
end