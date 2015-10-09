class Sitemap::ForumsBuilder < Sitemap::Worker
  class << self
    private

    def collection
      forum_collection.flatten
    end

    def forum_collection
      Forum.unscoped.visible.order(id: :asc).eager_load(:topics).map do |f|
        if f.topics.size > 25
          (2..(f.topics.size/25.0).ceil).to_a.inject([{forum: f}]) { |s, i| s.push({forum: f, page: i}) }
        else
          {forum: f}
        end
      end
    end

    def path(object)
      helper.forum_path(object[:forum].id, page: object[:page])
    end

    def date(object)
      object[:forum].updated_at
    end
  end
end
