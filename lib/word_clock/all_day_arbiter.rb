# frozen_string_literal: true
module WordClock
  class AllDayArbiter
    def initialize(time)
      @time = time
    end

    def match?(time)
      time.day == @time.day && time.month == @time.month
    end
  end
end
