class Sitemap::Worker
  class << self
    def gather
      gather_objects.map {|object| {url: path(object), lastmod: date(object)}}
    end

    private

    def gather_objects
      []
    end

    def path(object)
      object.class.to_s.downcase
    end

    def lastmod
      object.updated_at
    end
  end
end
