# frozen_string_literal: true

module WordClock
  class DeltaCalculator
    def initialize(luminance, delta)
      @luminance = luminance
      @delta = delta
    end

    def to_range
      lower = @luminance - @delta / 2
      upper = @luminance + @delta / 2

      lower = 0 if lower.negative?

      lower..upper
    end
  end
end
