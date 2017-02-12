# frozen_string_literal: true
require 'easter'
require 'word_clock/color'

module WordClock
  # Delegate to the given color sampler
  class Picker
    extend Forwardable
    def_delegator :@color_sampler, :sample

    def initialize(color_sampler)
      @color_sampler = color_sampler
    end
  end

  # Always return the same color
  class StaticColorPicker
    def initialize(color)
      @color = color
    end

    def sample(time=nil)
      @color
    end
  end

  # Sample random colors with each call to select
  class CarnivalPicker < Picker
    # TODO: use a range to express time >= "11.11. 11:11" && time <= "11.11. 23:59"
    def match?(time)
      time.month == 11 && time.day == 11 && time.hour == 11 && time.min == 11
    end
  end

  class AllDayPicker < Picker
    def initialize(color_sampler, time)
      super(color_sampler)
      @time = time
    end

    def match?(time)
      time.day == @time.day && time.month == @time.month
    end
  end

  class ColorPicker
    def initialize(color_sampler)
      @color_sampler = color_sampler

      always_grey = StaticColorPicker.new(Color.new(127, 127, 127))

      @samplers = [
        CarnivalPicker.new(color_sampler),
        AllDayPicker.new(color_sampler, Time.parse('April 8')),
        AllDayPicker.new(color_sampler, Easter.easter - 48), # Rosenmontag
        AllDayPicker.new(color_sampler, Easter.easter - 47), # Faschingsdienstag
        AllDayPicker.new(always_grey,   Easter.easter - 46), # Aschermittwoch
      ]
    end

    def choose(time=nil)
      @samplers.each do |sampler|
        return sampler.sample(time) if sampler.match?(time)
      end

      @color ||= @color_sampler.sample(time)
    end
  end
end
