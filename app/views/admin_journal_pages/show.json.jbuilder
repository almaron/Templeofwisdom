json.(@page, :id, :journal_id, :head, :content_text, :content_line)
json.images_attributes @page.images do |image|
  json.(image, :id, :page_id)
  json.image_url image.image_url
  json.thumb image.image_url(:thumb)
end