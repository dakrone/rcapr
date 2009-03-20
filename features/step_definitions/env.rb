require 'yaml'

f = File.new(File.dirname(__FILE__) + "/config.yml", "r")
@config = YAML.load(f)
@username = @config[:username]
@password = @config[:password]
