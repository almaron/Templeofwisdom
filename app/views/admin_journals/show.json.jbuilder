json.(@journal, :id, :head, :description)
json.cover_url @journal.cover_url if @journal.cover?

json.pages @journal.pages do |page|
  json.(page, :id, :head, :page_type)
  json.type_line I18n.t("journal.pages.page_type.#{page.page_type}")
end