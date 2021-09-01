require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end

require 'bundler/setup'

require_relative '../view'
require_relative '../game'
require_relative '../menu'
