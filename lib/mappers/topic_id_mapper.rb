module Mappers
  class TopicIdMapper
    attr_reader :db

    def initialize
      db_params = { host: '104.131.201.9', username: 'bao', password: 'malkavian', reconnect: true }
      forum_db = -> { Mysql2::Client.new db_params.merge database: 'temple_forum' }
      @db = forum_db.call
    end

    def map
      temple_ids = db.query('SELECT topic_id from hor_topics order by topic_id asc').map {|row| row['topic_id']}
      map = []
      ForumTopic.unscoped.order(:id).pluck(:id).each_with_index do |id, index|
        map[id] = temple_ids[index]
      end
      map
    end
  end
end
