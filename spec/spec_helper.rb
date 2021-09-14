require 'bundler/setup'
Bundler.setup(:defaults, :development, :test)

require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end

require 'codebreaker_console'
