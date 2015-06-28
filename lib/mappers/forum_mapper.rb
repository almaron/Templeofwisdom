module Mappers
  class ForumMapper
    class << self
      def map
        map = []
        db.query(query).each do |f|
          forum = Forum.find_or_create_by name: f['name']
          map[f['id']] = forum.id
        end
        map
      end

      private

      def query
        'SELECT forum_id as id, forum_name as name '\
        'FROM hor_forums WHERE forum_id IN ( '\
          'SELECT DISTINCT forum_id FROM hor_topics '\
        ')'
      end

      def db
        @db ||= Mysql2::Client.new host: 'templeofwisdom.ru', username: 'bao', password: 'malkavian', database: 'temple_forum'
      end
    end
  end
end

