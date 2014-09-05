json.(@page, :id, :journal_id, :head, :content_text, :content_line, :page_type)
json.type_line I18n.t("journal.pages.page_type.#{@page.page_type}")

if @page.is_gallery?
  json.images_attributes @page.images do |image|
    json.(image, :id, :page_id)
    json.image_url image.image_url
    json.thumb image.image_url(:thumb)
  end
end

if @page.is_article?
  json.images_attributes @page.images
end
