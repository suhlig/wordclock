# frozen_string_literal: true

module WordClock
  class RandomColorSampler
    def initialize
      Kernel.srand
    end

    def sample
      # Using Kernel.rand because it is easier mockable than rand
      Color.new(Kernel.rand(255), Kernel.rand(255), Kernel.rand(255))
    end
  end
end
