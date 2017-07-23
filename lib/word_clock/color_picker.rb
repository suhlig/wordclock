# frozen_string_literal: true

require 'word_clock/color'
require 'word_clock/static_color_sampler'
require 'word_clock/all_day_arbiter'
require 'word_clock/carnival_arbiter'
require 'word_clock/new_year_arbiter'
require 'time'

module WordClock
  class ColorPicker
    def initialize(sampler)
      @sampler = sampler

      always_grey = StaticColorSampler.new(Color.new(64, 64, 64))

      @samplers = {
        CarnivalArbiter.new => sampler,
        AllDayArbiter.new(Easter.ash_wednesday)     => always_grey,
        AllDayArbiter.new(Time.parse('January 13')) => sampler,
        AllDayArbiter.new(Time.parse('March 10'))   => sampler,
        AllDayArbiter.new(Time.parse('April 8'))    => sampler,
        AllDayArbiter.new(Time.parse('July 18'))    => sampler,
        AllDayArbiter.new(Time.parse('Dec 31'))     => sampler,
        NewYearPartyArbiter.new                     => sampler,
        NewYearHangoverArbiter.new                  => always_grey,
      }
    end

    def choose(time)
      @samplers.each do |arbiter, sampler|
        return sampler.sample if arbiter.match?(time)
      end

      @color ||= @sampler.sample
    end
  end
end
