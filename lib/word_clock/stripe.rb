# frozen_string_literal: true
require 'faderuby'
require 'logger'

#
# Idea: Treat the whole thing as one logical stripe of LEDs and let a physical
# layer underneath figure out how to map a logical pixel to a physical position
#
module WordClock
  class Stripe
    # All words on the [WC24h](https://www.mikrocontroller.net/articles/WordClock_mit_WS2812#WC24h_Sammelbestellung_Frontplatten)
    STRIPE = 'ESAISTOVIERTELEINSDREINERSECHSIEBENEELFÜNFNEUNVIERACHTNULLZWEINZWÖLFZEHNUNDOZWANZIGVIERZIGDREISSIGFÜNFZIGUHRMINUTENIVORUNDNACHEINDREIVIERTELHALBSIEBENEUNULLZWEINEFÜNFSECHSNACHTVIERDREINSUNDAELFEZEHNZWANZIGGRADREISSIGVIERZIGZWÖLFÜNFZIGMINUTENUHREFRÜHVORABENDSMITTERNACHTSMORGENSWARMMITTAGS'

    def initialize(logger: default_logger)
      @logger = logger
    end

    #
    # For the given hour and minute, return the indices of all pixels to be lit
    # in the stripe of pixels
    #
    def pixels(hour, minute)
      return lookup('ES', 'IST', 'MITTERNACHT') if hour.zero? && minute.zero?
      return lookup('ES', 'IST', 'EINE', 'MINUTE', 'NACH', 'MITTERNACHT') if hour.zero? && 1 == minute
      return lookup('ES', 'IST', minute_words(minute), 'MINUTEN', 'NACH', 'MITTERNACHT') if hour.zero? && (2..5).cover?(minute)
      return lookup('ES', 'IST', 'HALB', 'EINS') if hour.zero? && 30 == minute
      return lookup('ES', 'IST', 'HALB', hour_words(hour + 1)) if 13 > hour && 30 == minute

      lookup('ES', 'IST', hour_words(hour), 'UHR', minute_words(minute))
    end

    #
    # For the given pixel indices, return the words (without spaces) that are lit
    #
    def reverse(pixels)
      Array(pixels).map{ |i| STRIPE[i] }.join
    end

    private

    attr_reader :logger

    def default_logger
      Logger.new(STDERR).tap do |logger|
        logger.level = Logger::WARN
      end
    end

    def lookup(*words)
      index = 0

      words.compact.flatten.map do |word|
        next if word.nil?
        index = STRIPE.index(word, index)
        last = index + word.length - 1
        (index..last).to_a
      end.compact.flatten.tap do |result|
        logger.debug "#{words}: #{result}"
      end
    end

    def hour_words(hour)
      [
        'NULL',
        'EIN',
        'ZWEI',
        'DREI',
        'VIER',
        'FÜNF',
        'SECHS',
        'SIEBEN',
        'ACHT',
        'NEUN',
        'ZEHN',
        'ELF',
        'ZWÖLF',
        %w(DREI ZEHN),
        %w(VIER ZEHN),
        %w(FÜNF ZEHN),
        %w(SECH ZEHN),
        %w(SIEBEN ZEHN),
        %w(ACHT ZEHN),
        %w(NEUN ZEHN),
        'ZWANZIG',
        %w(EIN UND ZWANZIG),
        %w(ZWEI UND ZWANZIG),
        %w(DREI UND ZWANZIG)
      ][hour]
    end

    def minute_words(minute)
      [
        nil,
        'EINS',
        'ZWEI',
        'DREI',
        'VIER',
        'FÜNF',
        'SECHS',
        'SIEBEN',
        'ACHT',
        'NEUN',
        'ZEHN',
        'ELF',
        'ZWÖLF',
        %w(DREI ZEHN),
        %w(VIER ZEHN),
        %w(FÜNF ZEHN),
        %w(SECH ZEHN),
        %w(SIEBEN ZEHN),
        %w(ACHT ZEHN),
        %w(NEUN ZEHN),
        'ZWANZIG',
        %w(EIN UND ZWANZIG),
        %w(ZWEI UND ZWANZIG),
        %w(DREI UND ZWANZIG),
        %w(VIER UND ZWANZIG),
        %w(FÜNF UND ZWANZIG),
        %w(SECHS UND ZWANZIG),
        %w(SIEBEN UND ZWANZIG),
        %w(ACHT UND ZWANZIG),
        %w(NEUN UND ZWANZIG),
        'DREISSIG',
        %w(EIN UND DREISSIG),
        %w(ZWEI UND DREISSIG),
        %w(DREI UND DREISSIG),
        %w(VIER UND DREISSIG),
        %w(FÜNF UND DREISSIG),
        %w(SECHS UND DREISSIG),
        %w(SIEBEN UND DREISSIG),
        %w(ACHT UND DREISSIG),
        %w(NEUN UND DREISSIG),
      ][minute]
    end
  end
end
