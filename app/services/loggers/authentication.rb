module Loggers
  class Authentication < Base
    private

    # Always awaits a password key and a success key
    def message(options={})
      if options[:success]
        "Вошел(а) на сайт с паролем '#{options[:password]}' с ip #{options[:ip]}"
      else
        "Не смог(ла) войти на сайт с паролем '#{options[:password]}' с ip #{options[:ip]}"
      end
    end

    def log_id
      1
    end
  end
end
