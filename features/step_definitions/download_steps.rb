$:.unshift File.join(File.dirname(__FILE__))

require 'spec/expectations'
require 'rcapr'
require 'env'

Before do
  @rc = Rcapr.new(@username, @password)
end

After do
end

Given /^I have a pcap file id (\d+)$/ do |id|
    pending
end

When /^I download the pcap file$/ do
    pending
end

Then /^the pcap file should be download$/ do
    pending
end
