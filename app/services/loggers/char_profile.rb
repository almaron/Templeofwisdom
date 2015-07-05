module Loggers
  class CharProfile < Base

    private

    def message(options={})
      "Отредактирована анкета персонажа #{options[:char_name]}"
    end

    def log_id
      2
    end
  end
end
