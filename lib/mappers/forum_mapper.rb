module Mappers
  class ForumMapper
    class << self
      def map
        map = []
        db.query(query).each do |f|
          forum = Forum.find_by name: f['name']
          until false do
            if forum
              map[f['id']] = forum.id
              break
            else
              puts 'Форум не найден, введите id форума: '
              fid = STDIN.gets.strip.to_i
              forum = Forum.find_by id: fid
            end
          end
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
        @db ||= Mysql2::Client.new host: 'old.templeofwisdom.ru', username: 'bao', password: 'malkavian', database: 'temple_forum'
      end
    end
  end
end

