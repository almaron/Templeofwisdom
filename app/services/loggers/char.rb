module Loggers
  class Char < Base
    private

    def message(options={})
      "Персонаж #{options[:char_name]} #{I18n.t("common.char.actions.#{options[:action]}")}"
    end

    def log_id
      2
    end
  end
end
