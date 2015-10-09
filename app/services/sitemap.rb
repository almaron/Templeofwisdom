module Sitemap
  def self.builders
    [
      RootsBuilder,
      ForumsBuilder,
      TopicsBuilder,
      PagesBuilder,
      CharsBuilder,
      RolesBuilder,
      SprStonesBuilder,
      SprHerbsBuilder
    ]
  end
end
