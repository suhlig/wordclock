# frozen_string_literal: true
require 'easter'

module WordClock
  class Computus
    class << self
      def ash_wednesday
        AllDayMatcher.new(Easter.ash_wednesday)
      end

      def shrove_monday
        AllDayMatcher.new(Easter.easter - 48)
      end

      def shrove_tuesday
        AllDayMatcher.new(Easter.easter - 47)
      end
    end
  end

  class CarnivalMatcher
    # TODO: use a range to express time >= "11.11. 11:11" && time <= "11.11. 23:59"
    def match(time)
      time.month == 11 && time.day == 11 && time.hour == 11 && time.min == 11
    end
  end

  class AllDayMatcher
    def initialize(time)
      @time = time
    end

    def match(time)
      time.day == @time.day && time.month == @time.month
    end
  end

  class CalendarFacade
    def initialize(sampler)
      @sampler = sampler
      @matchers = [
        CarnivalMatcher.new,
        AllDayMatcher.new(Time.parse('April 8')),
        Computus.shrove_monday,
        Computus.shrove_tuesday,
        Computus.ash_wednesday,
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
