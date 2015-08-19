module JournalsHelper

  def thumbs_hash
    @page.images.map {|img| img.image_url(:thumb)}.to_json.gsub('"',"'")
  end

  def image_hash
    @page.images.map(&:image_url).to_json.gsub('"',"'")
  end
end
