class Redirects::ForumRedirect
  class << self
    def redirect(forum_id)
      rid = real_id(forum_id)
      rid ? routes.forum_path(rid) : routes.forums_path
    end

    private

    def real_id(forum_id)
      forums_map[forum_id.to_i]
    end

    def forums_map
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 10, 94, 12, 21, 23, 22, 14, nil, nil, nil, nil, nil, nil, nil, 79, 80, nil, 13, 15, 20, 17, 19, 18, 96, 34, 33, 24, 25, 31, 30, 97, 29, 32, 35, 36, 52, 53, 54, 47, 48, 49, 50, nil, 56, 87, 86, 95, 51, 61, 69, 58, 57, 59, 82, 26, 83, 37, 55, 38, 39, 60, 65, 40, 41, 66, 90, 42, 43, 63, nil, 84, 78, 62, 93, 92, 27, 76, 77, 44, 45, 85, 99, 64, 103, 68, 101]
    end

    def routes
      Rails.application.routes.url_helpers
    end
  end

end
