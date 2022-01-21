require 'rubocop'
require 'rubocop-rails'
require 'rubocop-rspec'
require 'rubocop-performance'
require 'rubocop-airbnb'

RuboCop::RakeTask.new do |task|
    task.requires << 'rubocop-rails' << 'rubocop-rspec' << 'rubocop-performance' << 'rubocop-airbnb'
end
