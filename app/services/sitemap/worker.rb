class Sitemap::Worker
  class << self
    def collect
      collection.map {|object| {path: path(object), lastmod: date(object)}}
    end

    private

    def collection
      []
    end

    def path(object)
      object.class.to_s.downcase
    end

    def lastmod
      object.updated_at
    end

    def helper
      Rails.application.routes.url_helpers
    end
  end
end
