class Sitemap::PagesBuilder < Sitemap::Worker
  class << self
    private

    def collection
      Page.all.to_a
    end

    def path(object)
      helper.page_url_path(object.page_alias)
    end
  end
end
