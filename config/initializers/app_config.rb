FIXED_CONFIG = YAML.load(File.read(Rails.root.join('config','app_config.yml'))).deep_symbolize_keys

class String
  def first_sentence
    self.split('.')[0]
  end
end