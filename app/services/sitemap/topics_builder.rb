class Sitemap::TopicsBuilder < Sitemap::Worker
  class << self
    private

    def collection
      topics_collection.flatten
    end

    def topics_collection
      ForumTopic.unscoped.where(forum_id: visible_forums).shown.order(id: :asc).map do |t|
        if t.posts_count
          (2..(t.posts_count/25.0).ceil).to_a.inject([{topic: t}]) { |s, i| s.push({topic: t, page: i}) }
        else
          {topic: t}
        end
      end
    end

    def visible_forums
      Forum.visible.pluck(:id)
    end

    def path(object)
      helper.forum_topic_path(object[:topic].forum_id, object[:topic].id, page: object[:page])
    end

    def date(object)
      object[:topic].updated_at
    end
  end
end
