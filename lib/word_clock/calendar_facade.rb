# frozen_string_literal: true
module WordClock
  class CalendarFacade
    def initialize(sampler)
      @sampler = sampler
    end

    def sample(time=nil)
      @color ||= @sampler.sample(time)
    end
  end
end
