#!/usr/bin/env ruby

require 'rubygems'
require 'httparty'
require 'pp'
require 'json'

class Rcapr
  def initialize(username, password)
    @username = username
    @password = password
    @api = RcaprAPI.new(@username, @password)
  end

  def upload(filename)
    result = @api.upload(filename)
    #pp result
    # TODO: de-stub
    #return '{ okay: true, id: "uploaded-pcap" }'
  end
end

# (598)-~% curl --basic -u user@domain.com:******* -F file=@t.pcap -F description="testing the API" -F tags="api" http://www.pcapr.net/api/upload
# ({id:"c6be820e5c1cf9f9f37871602c7a8ed1", okay:true})

class RcaprAPI
  include HTTParty
  base_uri 'http://www.pcapr.net/api'

  def initialize(u, p)
    @auth = {:username => u, :password => p}
  end

  def upload(file)
    begin
      options = { :basic_auth => @auth, :file => file }
      self.class.post('/upload', options)
    rescue
      return {:okay => false}.to_json
    end
  end

end
