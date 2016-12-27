# frozen_string_literal: true
module WordClock
  module Terminal
    class Pixel
      OFF = { r: 0, g: 0, b: 0 }.freeze

      def initialize(char)
        @color = OFF.dup
        @char = char
      end

      def set(color)
        @color = color
      end

      def to_s
        if OFF == @color
          '.'
        else
          @char # TODO: colorize
        end
      end
    end
  end
end
