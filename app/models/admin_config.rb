class AdminConfig < ActiveRecord::Base

  default_scope { order(:name) }

  def self.to_hash
    self.all.each_with_object({}) {|config, appconf| appconf[config.name.to_sym] = config.value.to_i > 0 ? config.value.to_i : config.value}
  end

end
