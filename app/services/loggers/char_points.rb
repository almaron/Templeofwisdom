module Loggers
  class CharPoints < Base
    LOG_TYPE = 3

    private

    def message(options={})
      "Персонажу #{options[:char_name]} изменены баллы на #{options[:value]}"
    end

    def log_id
      2
    end
  end
end
