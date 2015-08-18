class Statistics::PostCount < ActiveRecord::Base
  class << self
    def create_date(date = Date.today)
      self.create date: date, count: show_date(date)
    end

    def show_date(date = Date.today)
      ForumPost.where('created_at >= ? AND created_at < ?', get_time_range(date)[:start], get_time_range(date)[:end]).count
    end

    def today
      ForumPost.where('created_at >= ?', midnight(Date.today)).count
    end

    private

    def get_time_range(date)
     {
       start: midnight(date) - 1.day,
       end: midnight(date)
     }
    end

    def midnight(date)
      date.to_datetime.in_time_zone('Moscow').midnight
    end
  end

  default_scope -> { order(date: :desc) }
end
