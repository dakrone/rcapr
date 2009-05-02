
# (598)-~% curl --basic -u user@domain.com:******* -F file=@t.pcap -F description="testing the API" -F tags="api" http://www.pcapr.net/api/upload
# {id:"c6be820e5c1cf9f9f37871602c7a8ed1", okay:true}

class RcaprAPI
  BASE_URI = 'http://www.pcapr.net/api'

  def initialize(u, p)
    @username = u
    @password = p
    @res = RestClient::Resource.new(BASE_URI, :user => u, :password => p)
  end

  # Given a file, upload the file
  def upload(file)
    raise "File does not exist" unless File.exist?(file)

    #result = `curl --basic -u #{@auth[:username]}:#{@auth[:password]} -F file=@#{file} -F description="testing the API" -F tags="api" http://www.pcapr.net/api/upload`
    result = @res["/upload"].post, { :file => File.read(file), :description => "Testing the API", :tags => "api" }
    return nil if result.nil?
    return result.to_json
  rescue
    puts $!
    return {:okay => false}.to_json
  end

  # Given an id and filename, download the pcap to the particular file
  def download(id, filename)
    open(filename, "w").write(@res["/download?id=#{id}"].get)
    return filename
  rescue
    puts $!
    return nil
  end

end
