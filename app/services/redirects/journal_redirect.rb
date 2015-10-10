module Redirects
  class JournalRedirect
    attr_reader :journal_slug, :page_slug

    def initialize(journal_slug, page_slug=nil)
      @journal_slug, @page_slug = journal_slug, page_slug
    end

    def redirect
      page_id > 0 ? page_redirect : journal_redirect
    end

    private

    def routes
      Rails.application.routes.url_helpers
    end

    def journal_redirect
      routes.journal_path journal_id
    end

    def page_redirect
      routes.page_journal_path page_id
    end



  end
end

