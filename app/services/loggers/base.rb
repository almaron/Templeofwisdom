module Loggers
  class Base
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def log(options = {})
      SysLog.delay.create log_type_id: log_id, user: user_name, message: message(options)
    end

    private

    def user_name
      user.is_a?(User) ? user.name : user.to_s
    end

    def message(options={})
      ''
    end

    def log_id
      0
    end
  end
end
