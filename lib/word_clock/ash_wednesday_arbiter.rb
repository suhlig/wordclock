# frozen_string_literal: true

require 'easter'

module WordClock
  class AshWednesdayArbiter
    def match?(time)
      return time.to_date == Easter.ash_wednesday(time.year)
    end
  end
end
