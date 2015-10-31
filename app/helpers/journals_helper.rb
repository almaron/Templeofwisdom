module JournalsHelper

  def thumbs_hash
    @page.images.map {|img| img.image_url(:thumb)}.to_json.gsub('"',"'")
  end

  def image_hash
    @page.images.map(&:image_url).to_json.gsub('"',"'")
  end

  def og_image
    return nil unless @page
    if @page.images.any?
      @page.images.first.image_url
    elsif @page.blocks.any? && @page.blocks[0].image?
      @page.blocks[0].image_url
    else
      image_path('logo.png')
    end
  end

  def og_author
    @page && @page.is_article? ? @page.content_line : 'редакция "Монастырские Хроники"'
  end
end
