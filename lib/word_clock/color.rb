# frozen_string_literal: true

module WordClock
  class Color
    attr_reader :red, :green, :blue

    def initialize(red, green, blue)
      @red   = red
      @green = green
      @blue  = blue
    end

    def luminance
      0.3 * @red + 0.59 * @green + 0.11 * @blue
    end

    def to_h
      { r: @red, g: @green, b: @blue }
    end

    def to_s
      "[#{red},#{green},#{blue}]"
    end
  end
end
