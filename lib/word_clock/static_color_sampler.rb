# frozen_string_literal: true
require 'easter'
require 'word_clock/color'

module WordClock
  class StaticColorSampler
    def initialize(color)
      @color = color
    end

    def sample
      @color
    end
  end
end
