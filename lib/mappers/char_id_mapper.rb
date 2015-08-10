module Mappers
  class CharIdMapper
    attr_reader :db

    def initialize(db)
      @db = db
    end

    def map
      map = []
      db.query('select id, name FROM anketa').each do |row|
        name = row['name'].strip
        char = Char.find_by name: name
        if char
          map[char.id] = row['id']
        else
          puts "#{name} не найден"
        end
        map
      end
    end
  end
end
