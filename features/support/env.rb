require 'cucumber/rspec/doubles'
require 'rspec'
require 'conjur/api'
require 'conjur/config'

puts JSON.parse(File.read('conjur.json')).symbolize_keys

Conjur::Config.merge JSON.parse(File.read('conjur.json'))
Conjur::Config.apply
