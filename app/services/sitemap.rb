module Sitemap
  def self.builders
    [
      RootsBuilder,
      ForumsBuilder,
      TopicsBuilder,
      PagesBuilder,
      CharsBuilder,
      RolesBuilder,
      SprsBuilder
    ]
  end
end
