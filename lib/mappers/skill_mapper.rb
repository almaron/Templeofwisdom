module Mappers
  class SkillMapper
    class << self
      def map
        map = []
        db.query('SELECT id, name FROM a_skills').each do |sk|
          map[sk['id']] = Skill.find_by(name: sk['name']).id
        end
        map
      end

      private

      def db
        @db ||= Mysql2::Client.new host: 'templeofwisdom.ru', username: 'bao', password: 'malkavian', database: 'temple_main'
      end
    end
  end
end
