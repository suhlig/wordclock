# frozen_string_literal: true

require 'rainbow'

module WordClock
  module Terminal
    # A single character cell for the terminal simulator. Mirrors the
    # set(r:, g:, b:) interface of FadeRuby::Pixel.
    class Pixel
      OFF = { r: 0, g: 0, b: 0 }.freeze

      def initialize(char)
        @color = OFF
        @char = char
      end

      # rubocop:disable-next Naming/MethodParameterName
      def set(r: nil, g: nil, b: nil)
        @color = {
          r: r || @color[:r],
          g: g || @color[:g],
          b: b || @color[:b]
        }
      end

      def to_s
        if @color == OFF
          Rainbow(@char).color(43, 43, 43)
        else
          Rainbow(@char).color(@color[:r], @color[:g], @color[:b])
        end
      end
    end
  end
end
