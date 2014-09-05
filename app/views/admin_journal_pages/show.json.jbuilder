json.(@page, :id, :journal_id, :head, :content_line, :page_type)
json.type_line I18n.t("journal.pages.page_type.#{@page.page_type}")

if @page.is_article? || @page.is_blocks?
  json.images_attributes @page.images do |image|
    json.id image.id
    json.image_url image.image_url
  end
end

if @page.is_gallery?
  json.images @page.images do |image|
    json.id image.id
    json.name image.image
    json.url image.image_url
  end
  json.images_attributes []
end

if @page.is_gallery? || @page.is_article?
  json.(@page, :content_text)
end

if @page.is_blocks?
  json.content_blocks @page.blocks_content.map(&:content)
end
