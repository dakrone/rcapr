#!/usr/bin/env ruby

require 'rubygems'
require 'httparty'
require 'pp'
require 'json'
require 'open-uri'

class Rcapr
  def initialize(username, password)
    @username = username
    @password = password
    @api = RcaprAPI.new(@username, @password)
  end

  def upload(filename)
    result = JSON.parse(@api.upload(filename))
    #result = @api.upload(filename)
    # '{ okay: true, id: "uploaded-pcap" }'
    return result[:okay]
  end

  def download(id, filename="out.pcap")
    result = @api.download(id, filename)
    #STDERR.puts "\nresult(#{id}): [#{result}]"
    # TODO: get the actual file
    #filename = "test"
    return filename
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
      options = { :basic_auth => @auth, :file => "@#{file}" }
      result = self.class.post('/upload', options)
      STDERR.puts "result: #{result}"
      return result
    rescue
      return {:okay => false}.to_json
    end
  end

  def download(id, filename)
    begin
      #options = { :basic_auth => @auth }
      #response = self.class.post("/download?id=#{id}", options)
      #STDERR.puts "\n", response.code, response.body, response.headers.inspect

      open("#{filename}","w").write(open("http://www.pcapr.net/api/download?id=#{id}",
                                         { :http_basic_authentication => [@auth[:username],
                                                                          @auth[:password]] }).read)

      #Net::HTTP.start("http://www.pcapr.net/api") { |http|
        #resp = http.get("/download?id=#{id}")
        #open("#{filename}", "w") { |file|
          #file.write(resp.body)
        #}
      #}
    rescue
      STDERR.puts "\nr(#{id}): [#{$!}]"
      return {:okay => false}.to_json
    end
    return true
  end

end
