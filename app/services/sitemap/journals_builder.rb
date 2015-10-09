class Sitemap::JournalsBuilder < Sitemap::Worker
  class << self
    private

    def collection
      journal_map.flatten
    end

    def path(object)
      object.is_a?(Journal) ? helper.journal_path(object.id) : helper.page_journal_path(object.journal_id, object.id)
    end

    def journal_map
      Journal.eager_load(:pages).map { |j| [j, j.pages.to_a] }
    end
  end
end
