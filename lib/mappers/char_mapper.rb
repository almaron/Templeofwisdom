module Mappers
  class CharMapper
    attr_reader :log, :db
    def initialize(db, log)
      @db = db
      @log = log
    end

    def map
      db.forum_query('SELECT * FROM anketa ORDER BY name').each_with_index { |row, index| map_row row, index}
    end

    private

    def map_row(row, index)
      row['name'].strip!
      if Char.where(name: row['name']).any?
        puts "#{row['name']} already present"
        return
      end
      char = Char.new({
        name: row['name'],
        status_line: row['status'],
        status_id: status_map[row['stat_id']] || 5,
        group_id: group_map[row['stat_id']] || 6,
        open_player: row['viewcont']
      })
      char.build_profile({
        birth_date: date_parse(row['date']),
        age: row['age'],
        place: row['place'].strip,
        beast: row['anim'].strip,
        phisics: row['phisic'].gsub('<br />',''),
        items: row['items'].gsub('<br />',''),
        look: row['look'].gsub('<br />',''),
        bio: row['bio'].gsub('<br />',''),
        other: row['other'].gsub('<br />',''),
        comment: row['comments'].gsub('<br />',''),
        points: row['balls']
      })
      all_skills(row).each do |skill|
        char.char_skills.build skill_id: skill_map[skill['name'].to_i], level_id: level_map[skill['lvl'].to_i]
      end
      if char.save
        char.avatars.create remote_image_url: row['ava'], default: true
        puts "#{index}: #{char.name} save success"
      else
        puts "#{index}: #{char.name} save failed with #{char.errors.count} errors"
        log.error char.errors.full_messages.join("\n\n") + " - #{row['id']} - #{row['date']}"
      end
    end

    def skill_map
      @skill_map ||= SkillMapper.map
    end

    def level_map
      (1..7).to_a
    end

    def status_map
      [2, 3, nil, nil, nil, nil, 6, 6]
    end

    def group_map
      [nil, nil, 2, 3, 4, 5]
    end

    def all_skills(row)
      map = []
      [row['magic'], row['skills']].each do |line|
        map += [JSON.parse(line)].flatten if line.present?
      end
      map
    rescue JSON::ParserError
      []
    end

    def date_parse(date)
      parts = date.split('.')
      "#{parts[0]}.#{parts[1]}"
    end
  end
end
