module Mappers
  class TopicIdMapper
    attr_reader :db

    def initialize(db)
      @db = db
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
