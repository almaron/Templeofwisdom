module Mappers
  class CharIdMapper
    attr_reader :db

    def initialize
      db_params = { host: '104.131.201.9', username: 'bao', password: 'malkavian', reconnect: true }
      main_db = -> { Mysql2::Client.new db_params.merge database: 'temple_main' }
      @db = main_db.call
    end

    def map
      map = []
      db.forum_query('SELECT id, name FROM anketa').each do |row|
        name = row['name'].strip
        char = Char.find_by name: name
        if char
          map[char.id] = row['id']
        else
          puts "#{name} не найден"
        end
      end
      map
    end
  end
end
