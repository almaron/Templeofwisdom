module Redirects
  class JournalRedirect
    attr_reader :journal_slug, :page_slug

    def initialize(journal_slug, page_slug=nil)
      @journal_slug, @page_slug = journal_slug, page_slug
    end

    def redirect
      page_id ? page_redirect : journal_redirect
    end

    private

    def journal_redirect
      routes.journal_path journal_id
    end

    def page_redirect
      routes.page_journal_path journal_id, page_id
    end

    def journal_id
      @journal_id ||= search_hash[journal_slug]['id']
    end

    def page_id
      @page_id ||= search_hash[journal_slug]['pages'][page_slug]
    end
    
    def search_hash
      @hash = YAML.load_file(Rails.root.join('config', 'journals.yml'))
    end

    def routes
      Rails.application.routes.url_helpers
    end
  end
end

