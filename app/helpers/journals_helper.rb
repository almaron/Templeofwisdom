module JournalsHelper

  def thumbs_hash
    @page.images.map {|img| img.image_url(:thumb)}.to_json.gsub('"',"'")
  end

  def image_hash
    @page.images.map(&:image_url).to_json.gsub('"',"'")
  end

  def og_image
    return nil unless @page && @page.images.any?
    @page.images.first.image_url
  end

  def og_author
    @page && @page.is_article? ? @page.content_line : 'редакция "Монастырские Хроники"'
  end
end
