# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples_for_word_clock'

0.upto(23).each do |hour|
  require "word_clock/stripe_#{hour}_spec.rb"
rescue LoadError
  RSpec.describe WordClock::Clock24 do
    pending "spec for #{hour}:00..#{hour}:59"
  end
end
