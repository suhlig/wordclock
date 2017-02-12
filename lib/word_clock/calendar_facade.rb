# frozen_string_literal: true
module WordClock
  class CarnivalMatcher
    # TODO: Between 11.11. 11:11 and end of Faschingsdienstag
    def match(time)
      time.month == 11 && time.day == 11 && time.hour == 11 && time.min == 11
    end
  end

  class AllDayMatcher
    def initialize(day:, month:)
      @day = day
      @month = month
    end

    def match(time)
      time.day == @day && time.month == @month
    end
  end

  class CalendarFacade
    def initialize(sampler)
      @sampler = sampler
      @matchers = [
        CarnivalMatcher.new,
        AllDayMatcher.new(day: 8, month: 4)
      ]
    end

    def sample(time=nil)
      if @matchers.any? { |m| m.match(time) }
        @sampler.sample(time)
      else
        @color ||= @sampler.sample(time)
      end
    end
  end
end
