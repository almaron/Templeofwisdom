json.(@page, :id, :journal_id, :head, :content_line, :page_type, :tags)
json.type_line I18n.t("journal.pages.page_type.#{@page.page_type}")

if @page.is_article?
  json.images_attributes @page.images do |image|
    json.id image.id
    json.image_url image.image_url
  end
end

if @page.is_gallery?
  json.images @page.images do |image|
    json.id image.id
    json.image_url image.image_url
    json.thumb_url image.image_url(:thumb)
  end
  json.images_attributes []
end

if @page.is_gallery? || @page.is_article?
  json.(@page, :content_text)
end

if @page.is_blocks?
  json.blocks_attributes @page.blocks do |block|
    json.(block, :id, :content, :image_url)
  end
end
