require 'yaml'

# return the username and password, after reading a config.yml file
def get_creds
  # load config.yml in the same directory as env.rb
  f = File.new(File.dirname(__FILE__) + "/config.yml", "r")
  config = YAML.load(f)
  return config[:username], config[:password]
end
