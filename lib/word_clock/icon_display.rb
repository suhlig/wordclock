# frozen_string_literal: true
require 'word_clock'
require 'faderuby'

module WordClock
  class IconDisplay
    def initialize(host='localhost', port=7890)
      @client = FadeRuby::Client.new(host, port)
      @strip = FadeRuby::Strip.new(18 * 16)
    end

    def show(icon)
      reset
      icon.each.with_index do |icon, index|
        @strip.pixels[index] = FadeRuby::Pixel.new(icon)
      end

      @client.write(@strip)
    end

    def reset
      @strip.set_all(r: 0, g: 0, b: 0)
      @client.write(@strip)
    end
  end
end
