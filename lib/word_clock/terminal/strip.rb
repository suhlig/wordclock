# frozen_string_literal: true
require 'word_clock/terminal/pixel'

module WordClock
  module Terminal
    class Strip
      attr_reader :pixels

      def initialize(clock)
        @pixels = clock.chars.map do |char|
          Pixel.new(char)
        end
      end
    end
  end
end
