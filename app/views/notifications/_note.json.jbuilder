json.(note, :id, :head)
json.text note.text.bbcode_to_html_with_formatting
json.createdAt I18n.l(note.created_at, format: :full)
json.read note.read?