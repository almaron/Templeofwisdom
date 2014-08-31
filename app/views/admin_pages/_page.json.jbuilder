json.(page, :id, :head, :page_alias, :published, :parent_id)
json.isPublished page.published?
json.children page.children, partial: 'page', as: :page