class TopicLinkParser
  attr_reader :post, :url

  def initialize(post)
    @post = post
  end

  def parse
    # post.update text: parsed_text
    parsed_text
  end

  private

  TOPIC_REGEXP = /(\/?viewtopic.*?)[\]\[]/

  def parsed_text
    text = post.text
    post.text.scan(TOPIC_REGEXP).flatten.each do |url|
      @url = url
      text = text.gsub(url, new_path)
    end
    text
  end

  def new_path
    Redirects::TopicRedirect.new(green_params).redirect
  end

  def green_params
    hash = uri_params
    uri_params.each_pair {|k,v| hash[k] = v[0]}
  end

  def uri_params
    CGI.parse(URI.parse(url).query).symbolize_keys
  end
end
