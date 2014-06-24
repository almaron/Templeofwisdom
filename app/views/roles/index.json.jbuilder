json.array! @roles do |role|
  json.(role, :id, :head)
  json.createdAt I18n.l(role.created_at)
  json.chars_list role.char_roles.map {|ch| ch.char.name}.join(', ')
end