# frozen_string_literal: true

module WordClock
  class Color
    attr_reader :red, :green, :blue

    def initialize(red, green, blue)
      @red   = red
      @green = green
      @blue  = blue
    end

    def relative_luminance
      # https://en.wikipedia.org/wiki/Relative_luminance
      (0.2126 * @red + 0.7152 * @green + 0.0722 * @blue)  / 255
    end

    def to_h
      { r: @red, g: @green, b: @blue }
    end

    def to_s
      "[#{red},#{green},#{blue}]"
    end
  end
end
