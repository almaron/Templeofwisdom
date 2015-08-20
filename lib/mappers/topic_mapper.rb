module Mappers
  class TopicMapper
    attr_reader :db, :log

    def initialize(db,log)
      @db = db
      @log = log
    end

    def map
      load_chars
      puts 'Введите старт (0):'
      start_id = STDIN.gets.strip || 0
      db.forum_query("SELECT topic_id as id, forum_id, topic_title as head, topic_first_poster_name as poster FROM hor_topics WHERE topic_id >= #{start_id} ORDER BY topic_id").each_with_index do |row, index|
        map_topic row, index
      end
      dump_chars
    end

    private

    def forum_map
      @forum_map ||= ForumMapper.map
    end

    def load_chars
      @chars = {}
      File.readlines('tmp/chars_dump.txt').each do |line|
        breaks = line.strip.split('||&||')
        @chars[breaks[0]] = Char.find_by name: breaks[1]
      end
    end

    def dump_chars
      dump = []
      @chars.each_pair do |k, v|
        dump << "#{k}||&||#{v.name}" if v
      end
      File.open('tmp/chars_dump.txt','w+') { |f| f.puts dump }
    end

    def map_topic(row, index = 0)
      char = selected_char row['poster']
      topic = ForumTopic.new head: row['head'], forum_id: forum_map[row['forum_id']], char_id: char.id, poster_name: char.name
      build_posts(topic, row['id'])
      if topic.save
        puts "#{index} - #{topic.head} - success"
      else
        puts "#{index} - #{row['id']} - failed"
        log.error "#{row['id']} failed with #{topic.errors.count} errors"
        log.error topic.errors.full_messages.join "\n"
      end
    end

    def build_posts(topic, id)
      db.forum_query(posts_query(id)).each do |row|
        char = selected_char row['username']
        time = Time.at(row['post_time']).to_datetime
        topic.posts.build({
          char_id: char.id,
          user_id: char.owner.try(:id) || 1,
          text: parse_text(row['post_text']),
          ip: row['ip'],
          created_at: time,
          updated_at: time,
          avatar_id: char.default_avatar.try(:id)
        })
      end
    end

    def posts_query(topic_id)
      'SELECT hor_posts.poster_ip as ip, hor_posts.post_text, hor_posts.post_time, hor_users.username '\
      'FROM hor_users, hor_posts '\
      'WHERE hor_users.user_id = hor_posts.poster_id '\
      "AND hor_posts.topic_id = #{topic_id} "\
      'ORDER BY post_time'
    end

    def parse_text(text)
      text.gsub! /\[(\/?.+?):.+?\]/, '[\1]'
      text.gsub! '&#58;', ':'
      text.gsub! '&#46;', '.'
      text.gsub! /<!-- \w --><a .*? href="(.*?)".*?>(.*?)<\/a><!-- \w -->/, '[url=\1]\2[/url]'
      text
    end

    def selected_char(char_name)
      @chars ||= {}
      char = Char.find_by(name: char_name) || @chars[char_name]
      name = char_name
      until char do
        chars = Char.where("name LIKE '%#{name}%'").pluck(:name)
        puts "#{name} не существует."
        puts "Возможные варианты: #{chars.join(' , ')}"
        puts 'Введите новое имя:'
        new_name = STDIN.gets.strip
        if new_name.include? 'c:'
          char = create_char char_name, new_name
        else
          name = new_name
          char = Char.find_by name: name
        end
      end
      unless char.name == char_name
        @chars[char_name] = char
        dump_chars
      end
      char
    end

    def create_char(name, params)
      params = params.split(':')
      char = Char.create name: name, status_id: 5, group_id: params[2]
      char.delegate_to User.find(params[1]), owner: 1
      create_avatar char, name
      char
    end

    def create_avatar(char, name)
      unless (row = db.forum_query("select user_avatar from hor_users where username = '#{name}'").first)
        char.avatars.create({
          default: true,
          remote_image_url: "http://templeofwisdom.ru/temple/download/file.php?avatar=#{row['user_avatar']}"
        })
      end
    end
  end
end
