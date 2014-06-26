json.(note, :id, :head, :text)
json.createdAt I18n.l(note.created_at, format: :full)
json.read note.read?