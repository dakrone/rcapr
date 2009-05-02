# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'cucumber/rake/task'
require './lib/rcapr.rb'

Hoe.new('rcapr', Rcapr::VERSION) do |p|
  p.rubyforge_name = 'rcapr' # if different than lowercase project name
  p.developer('Lee Hinman', 'lee@writequit.org')
end

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--language en"
end

# vim: syntax=Ruby
