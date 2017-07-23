# frozen_string_literal: true

require 'word_clock/color'

module WordClock
  # Wraps another sampler and ensures that only colors
  # within a luminance range are sampled
  class LuminanceRangeSampler
    def initialize(delegate, luminance_range=0..65535)
      @delegate = delegate
      @luminance_range = luminance_range
    end

    def sample
      # TODO: Break if we cannot find a suitable candidate
      loop do
        candidate = @delegate.sample
        return candidate if @luminance_range.include?(candidate.relative_luminance)
        warn "Rejecting #{candidate} because its luminance #{candidate.relative_luminance} is outside #{@luminance_range}"
      end
    end
  end
end
