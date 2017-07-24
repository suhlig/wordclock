# frozen_string_literal: true

require 'word_clock/color'

module WordClock
  # Wraps another sampler and ensures that only colors
  # within a luminance range are sampled
  class LuminanceRangeSampler
    def initialize(delegate, relative_luminance_range=0..1)
      @delegate = delegate
      @relative_luminance_range = relative_luminance_range
    end

    def sample
      # TODO: Break if we cannot find a suitable candidate
      loop do
        candidate = @delegate.sample
        if @relative_luminance_range.include?(candidate.relative_luminance)
          warn "Accepting #{candidate} because its luminance #{candidate.relative_luminance} is within #{@relative_luminance_range}"
          return candidate
        end

        warn "Rejecting #{candidate} because its luminance #{candidate.relative_luminance} is outside #{@relative_luminance_range}"
      end
    end
  end
end
