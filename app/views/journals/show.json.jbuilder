json.(@journal, :id, :head)
json.cover @journal.cover_url if @journal.cover?
json.page_count @journal.pages.count
json.pages @journal.pages do |page|
  json.(page, :id, :head, :page_type)
  json.cached false
end
json.current_page -1