$:.unshift File.join(File.dirname(__FILE__))

require 'spec/expectations'
require 'rcapr'
require 'env'

Before do
  @rc = Rcapr.new(@username, @password)
end

After do
end

Given /^I have a pcap file ([\S.]+)$/ do |pcap_file|
  @filename = pcap_file
end

When /^I upload the pcap file$/ do
  @result = @rc.upload(@filename)
end

Then /^the pcap file should be uploaded$/ do
  @result.should =~ /\{ okay: true, id: "([\S]+)" \}/
end
