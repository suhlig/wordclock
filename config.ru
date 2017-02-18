require 'bundler'
Bundler.require

require_relative 'lib/word_clock/web/server'
run Sinatra::Application
