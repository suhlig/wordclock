# frozen_string_literal: true

require 'word_clock/color'

module WordClock
  class MinumumLuminanceSampler
    def initialize(luminance_range=0..255)
      @luminance_range = luminance_range
      Kernel.srand
    end

    def sample
      loop do
        c = self.class.sample
        return c if @luminance_range.include?(c.luminance)
      end
    end

    def self.sample
      # Using Kernel.rand because it is easier mockable than rand
      Color.new(Kernel.rand(255), Kernel.rand(255), Kernel.rand(255))
    end
  end
end
