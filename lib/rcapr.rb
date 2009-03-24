#!/usr/bin/env ruby

require 'rubygems'
require 'httparty'
require 'json'
require 'open-uri'

class Rcapr
  def initialize(username, password)
    @username = username
    @password = password
    @api = RcaprAPI.new(@username, @password)
  end

  def upload(filename)
    STDERR.puts "[+] uploading #{filename}"
    result = JSON.parse(@api.upload(filename))
    #result = @api.upload(filename)
    # '{ okay: true, id: "uploaded-pcap" }'
    return result[:okay]
  end

  def download(id, filename="out.pcap")
    @api.download(id, filename)
  end
end

# (598)-~% curl --basic -u user@domain.com:******* -F file=@t.pcap -F description="testing the API" -F tags="api" http://www.pcapr.net/api/upload
# {id:"c6be820e5c1cf9f9f37871602c7a8ed1", okay:true}

class RcaprAPI
  include HTTParty
  base_uri 'http://www.pcapr.net/api'

  def initialize(u, p)
    @auth = {:username => u, :password => p}
  end

  # Given a file, upload the file
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

  # Given an id and filename, download the pcap to the particular file
  def download(id, filename)
    begin
      open("#{filename}","w").write(
        open("http://www.pcapr.net/api/download?id=#{id}",
             { :http_basic_authentication => [@auth[:username],
               @auth[:password]] }
            ).read
      )

    rescue
      return nil
    end
    return filename
  end

end
