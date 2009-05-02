class Rcapr
  def initialize(username, password)
    @username = username
    @password = password
    @api = RcaprAPI.new(@username, @password)
  end

  def upload(filename)
    raise "File does not exist." unless File.exist?(filename)
    @api.upload(filename)
  end

  def download(id, filename="out.pcap")
    @api.download(id, filename)
  end
end

