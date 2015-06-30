module Loggers
  class Omniauth < Base
    private

    def message(options = {})
      if options[:success]
        "Вошел(а) через #{options[:provider].titleize} с ip #{options[:ip]}"
      else
        "Не смог(ла) войти через #{options[:provider].titleize} с ip #{options[:ip]}"
      end
    end

    def log_id
      1
    end
  end
end
