json.(blog_comment, :id, :comment, :user_id)
json.author blog_comment.author
json.content simple_format(blog_comment.comment)
json.dateLine I18n.l(blog_comment.created_at)