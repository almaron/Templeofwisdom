class Sitemap::Sitemap
  attr_accessor :url_list

  def initialize
    @url_list = []
  end

  def build
    File.open(Rails.root.join('public','sitemap.xml'), 'w+t') do |file|
      file.puts '<?xml version="1.0" encoding="UTF-8"?>'
      file.puts '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
      file.puts xml_url_list
      file.puts '</urlset>'
    end
  end

  private

  def xml_url_list
    build_url_list.map { |url| xml_line(url)}
  end

  def xml_line(url)
    "<url>\n  <loc>http://templeofwisdom.ru#{url[:path]}</loc>\n  <lastmod>#{to_string(url[:lastmod])}</lastmod>\n<url>"
  end

  def to_string(date)
    date.is_a? DateTime ? date.strftime('%Y-%m-%d') : date
  end

  def build_url_list

  end
end
