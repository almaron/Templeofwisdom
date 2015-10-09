class Sitemap::SprStonesBuilder < Sitemap::Worker
  class << self
    
    private
    
    def collection
      SprStone.all.to_a
    end
    
    def path(object)
      helper.stone_path(object.id)
    end
    
  end
end
