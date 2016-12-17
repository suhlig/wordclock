# frozen_string_literal: true
require 'word_clock'
require 'faderuby'

module WordClock
  class FadeCandy
    def initialize(host='localhost', port=7890)
      @client = FadeRuby::Client.new(host, port)
      @strip = FadeRuby::Strip.new(18 * 16)
    end

    def show(pixels=(0..WordClock::STRIPE.length - 1).to_a)
      reset
      color = { r: rand(50..255), g: rand(50..255), b: rand(50..255) }

      WordClock::STRIPE.chars.map.with_index do |c, i|
        pixel = @strip.pixels[i]

        if pixels.include?(i)
          pixel.set(color)
        end
      end

      @client.write(@strip)
    end

    def reset
      @strip.set_all(r: 0, g: 0, b: 0)
      @client.write(@strip)
    end
  end
end
