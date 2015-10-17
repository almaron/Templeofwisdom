class TopicLinkParser
  attr_reader :post, :url, :link

  def initialize(post)
    @post = post
  end

  def parse
    begin
      post.update text: parsed_text
    rescue StandardError => e

    end
  end

  TOPIC_REGEXP = /(\[url=?(.*?\/temple\/viewtopic.php\?.*?)?\])(.*?)\[\/url\]/mi

  def parsed_text
    text = post.text
    post.text.scan(TOPIC_REGEXP).each do |flap|
      @url = flap[1] || flap[2]
      @link = flap[2]
      text = text.gsub(flap[0], new_url).gsub(flap[2], new_link)
    end
    text
  end

  def new_url
    "[url=http://templeofwisdom.ru#{new_path}]"
  end

  def new_link
    link.include?('viewtopic') ? 'ссылка' : link
  end

  def new_path
    Redirects::TopicRedirect.new(green_params).redirect
  end

  def green_params
    hash = uri_params
    uri_params.each_pair {|k,v| hash[k] = v[0]}
    hash
  end

  def uri_params
    CGI.parse(URI.parse(url).query).symbolize_keys
  end
end
