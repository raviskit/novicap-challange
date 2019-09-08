#! /usr/bin/env ruby
require 'irb'
require 'json'

Dir['./lib/*.rb'].each{ |f| require f }

def pricing_rules
  file = File.read('discounts.json')
  JSON.parse(file)
end

IRB.start
