json.(@page, :id, :head, :content_line, :page_type)
if @page.is_article?
  json.content @page.content_text.bbcode_to_html_with_formatting
  json.image_url @page.image_url 0
end

json.cached true

if @page.is_blocks?
  json.content_blocks @page.blocks_content do |block|
    json.content block.content.bbcode_to_html_with_formatting
    json.image_url block.image_url
  end
end

if @page.is_gallery?
  json.content @page.content_text.bbcode_to_html_with_formatting
  json.images @page.images do |image|
    json.path image.image_url
    json.thumb image.image_url(:thumb)
  end
end

if @page.is_newbies?
  json.newbies @page.newbies do |char|
    json.(char, :id, :name)
    json.group I18n.t("char_groups.names.#{char.group.name}")
    json.place char.profile.place
    json.avatar char.avatar_url if char.avatar?
  end
end
