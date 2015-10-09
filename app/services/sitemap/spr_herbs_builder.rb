class Sitemap::SprHerbsBuilder < Sitemap::Worker
  class << self
    
    private
    
    def collection
      SprHerb.all.to_a
    end
    
    def path(object)
      helper.herb_path(object.id)
    end
    
  end
end