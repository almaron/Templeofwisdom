class Sitemap::RolesBuilder < Sitemap::Worker
  class << self

    private

    def collection
      Role.all.to_a
    end

    def path(object)
      helper.show_role_path(object.id)
    end
  end
end
