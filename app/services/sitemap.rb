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
      SprHerbs
    ]
  end
end
