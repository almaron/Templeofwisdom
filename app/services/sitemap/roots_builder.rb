class Sitemap::RootsBuilder < Sitemap::Worker
  class << self
    private

    def collection
      [
        [:root_path, nil, News],
        [:forums_path, nil, Forum],
        [:chars_path, nil, Char],
        [:skills_list_path, 'magic', Skill.magic],
        [:skills_list_path, 'phisic', Skill.phisic],
        [:guest_posts_path, nil, GuestPost],
        [:journals_path, nil, Journal],
        [:stones_path, nil, SprStone],
        [:herbs_path, nil, SprHerb]
      ]
    end

    def path(item)
      helper.send(item[0], item[1])
    end

    def date(item)
      item[2].order(updated_at: :desc).first.updated_at
    end
  end
end
