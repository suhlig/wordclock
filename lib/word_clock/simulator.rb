# frozen_string_literal: true
require 'word_clock'

module WordClock
  class Simulator
    #
    # Return 16 lines of 18 characters. If the position is not present
    # in +pixels+, replace it with a space.
    #
    def show(pixels = (0..WordClock::STRIPE.length - 1).to_a)
      WordClock::STRIPE.chars.map.with_index do |c, i|
        if pixels.include?(i)
          c
        else
          ' '
        end
      end.each_slice(18).map(&:join)
    end
  end
end
