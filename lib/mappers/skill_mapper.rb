module Mappers
  class SkillMapper
    attr_reader :db

    def initialize(db)
      @db = db
    end

    def map
      map = []
      db.query('SELECT id, name FROM a_skills').each do |sk|
        map[sk['id']] = Skill.find_by(name: sk['name']).id
      end
      map
    end
  end
end
