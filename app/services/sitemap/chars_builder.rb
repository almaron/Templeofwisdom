class Sitemap::CharsBuilder < Sitemap::Worker
  class << self
    private

    def collection
      Char.where('group_id > 1').active.to_a
    end

    def path(char)
      helper.char_path(char.id)
    end
  end
end
