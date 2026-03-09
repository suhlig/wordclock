# frozen_string_literal: true

source 'http://rubygems.org'

# Workaround for broken LOAD_PATH
# see https://github.com/ruby/json/issues/752#issuecomment-2660377640
$LOAD_PATH.unshift(*Gem::Dependency.new('json').to_spec.full_require_paths)

gem 'easter'
gem 'faderuby'
gem 'ostruct'
gem 'paint'
gem 'pnm'
gem 'rainbow'

group :development do
  gem 'bundler'
  gem 'guard-bundler'
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'pry-byebug'
  gem 'rake'
  gem 'rb-readline'
  gem 'rspec'
  gem 'rubocop'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'travis'
end
