# frozen_string_literal: true

module WordClock
  class NewYearPartyArbiter
    def match?(time)
      (Time.new(time.year, 1, 1, 0, 0)..Time.new(time.year, 1, 1, 3, 59, 59)).cover?(time)
    end
  end

  class NewYearHangoverArbiter
    def match?(time)
      (Time.new(time.year, 1, 1, 4, 0)..Time.new(time.year, 1, 1, 23, 59, 59)).cover?(time)
    end
  end
end
