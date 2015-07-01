json.(answer, :id, :text)
json.show_text answer.text.bbcode_to_html_with_formatting
json.date l(answer.created_at, format: :full)

json.user do
  json.(answer.user, :id, :name)
  json.master answer.user.is_in? [:admin, :master]
end
