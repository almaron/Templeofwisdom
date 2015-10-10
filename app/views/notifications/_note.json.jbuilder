json.(note, :id, :head)
json.text temple_format(note.text.bbcode_to_html)
json.createdAt I18n.l(note.created_at, format: :full)
json.read note.read?
