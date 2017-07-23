# frozen_string_literal: true

module WordClock
  class StaticColorSampler
    def initialize(color)
      @color = color
    end

    def sample
      @color
    end
  end
end
