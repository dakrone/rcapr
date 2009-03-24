require 'yaml'

# return the username and password
def get_creds
  f = File.new(File.dirname(__FILE__) + "/config.yml", "r")
  config = YAML.load(f)
  return config[:username], config[:password]
end
