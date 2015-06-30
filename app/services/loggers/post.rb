module Loggers
  class Post < Base
    private

    def message(options = {})
      "Отредактирован пост №#{options[:post].id}персонажа #{options[:post].char.name} в теме '#{options[:post].topic.head}'"
    end

    def log_id
      4
    end
  end
end
