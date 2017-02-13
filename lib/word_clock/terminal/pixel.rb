# frozen_string_literal: true
require 'rainbow'

module WordClock
  module Terminal
    class Pixel
      OFF = { red: 0, green: 0, blue: 0 }.freeze

      def initialize(char)
        @color = OFF.dup
        @char = char
      end

      def set(color)
        @color = color
      end

      def to_s
        if OFF == @color
          Rainbow(@char).color(43, 43, 43)
        else
          Rainbow(@char).color(@color.red, @color.green, @color.blue)
        end
      end
    end
  end
end
