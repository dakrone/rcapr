$:.unshift File.join(File.dirname(__FILE__))

require 'spec/expectations'
require 'rcapr'
require 'env'

Before do
  @username, @password = get_creds()
  @rc = Rcapr.new(@username, @password)
end

After do
  if File.exist?(@filename)
    File.delete(@filename)
  end
end

Given /^I have a pcap file id ([\da-f]+)$/ do |id|
  @id = id
end

When /^I download the pcap file$/ do
  f = "#{@id}.pcap"
  @filename = @rc.download(@id,f)
end

Then /^the pcap file should be download$/ do
  File.exist?(@filename).should == true
end
