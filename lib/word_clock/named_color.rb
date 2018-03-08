# frozen_string_literal: true

require 'word_clock/color'

module WordClock
  class NamedColor < Color
    attr_reader :name

    def initialize(red, green, blue, name)
      super(red, green, blue)
      @name = name
    end

    def to_s
      "#{super} (#{name})"
    end
  end
end
