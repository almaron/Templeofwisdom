module Loggers
  class Role < Base
    private

    def message(options={})
      if options[:create]
        "Добавлена ролевка '#{options[:head]}'(#{options[:id]})"
      else
        "Отредактирована ролевка '#{options[:head]}'(#{options[:id]})"
      end
    end

    def log_id
      3
    end
  end
end
