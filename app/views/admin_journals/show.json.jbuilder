json.(@journal, :id, :head, :description, :published)
json.cover_url @journal.cover_url if @journal.cover?

json.pages @journal.pages do |page|
  json.(page, :id, :head, :page_type, :sort_index)
  json.type_line I18n.t("journal.pages.page_type.#{page.page_type}")
end
