# frozen_string_literal: true
require 'word_clock/color'

module WordClock
  class NamedColor < Color
    attr_reader :name

    def initialize(r, g, b, name)
      super(r, g, b)
      @name = name
    end

    def to_s
      "#{super} (#{name})"
    end
  end
end
