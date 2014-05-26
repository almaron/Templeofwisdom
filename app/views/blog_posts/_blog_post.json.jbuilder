json.(blog_post, :id, :head, :text, :author)
json.dateLine I18n.l(blog_post.created_at)
json.content simple_format(blog_post.text)

json.comments blog_post.comments do |comment|
  json.partial! comment
end
