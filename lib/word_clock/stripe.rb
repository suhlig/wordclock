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
      return lookup('ES', 'IST', 'EINS', 'NACH', 'MITTERNACHT') if hour.zero? && 1 == minute # TODO obsolete?
      return lookup('ES', 'IST', minute_words(minute), 'NACH', 'MITTERNACHT') if hour.zero? && (2..5).cover?(minute)
      return lookup('ES', 'IST', 'FÜNF', 'NACH', 'MITTERNACHT') if hour.zero? && 5 == minute # TODO obsolete?
      return lookup('ES', 'IST', 'FÜNF', 'NACH', 'EINS') if 1 == hour && 5 == minute
      return lookup('ES', 'IST', 'FÜNF', 'NACH', hour_words(hour + 1)) if 13 > hour && 5 == minute
      return lookup('ES', 'IST', 'VIERTEL', 'EINS') if hour.zero? && 15 == minute
      return lookup('ES', 'IST', 'VIERTEL', hour_words(hour + 1)) if 13 > hour && 15 == minute
      return lookup('ES', 'IST', 'FÜNF', 'VOR', 'HALB', 'EINS') if hour.zero? && 25 == minute
      return lookup('ES', 'IST', 'FÜNF', 'VOR', 'HALB', hour_words(hour + 1)) if 13 > hour && 25 == minute
      return lookup('ES', 'IST', 'HALB', 'EINS') if hour.zero? && 30 == minute
      return lookup('ES', 'IST', 'HALB', hour_words(hour + 1)) if 13 > hour && 30 == minute
      return lookup('ES', 'IST', 'ZEHN', 'VOR', 'EINS') if hour.zero? && 50 == minute
      return lookup('ES', 'IST', 'ZEHN', 'VOR', hour_words(hour + 1)) if 13 > hour && 50 == minute
      return lookup('ES', 'IST', 'FÜNF', 'VOR', 'EINS') if hour.zero? && 55 == minute
      return lookup('ES', 'IST', 'FÜNF', 'VOR', hour_words(hour + 1)) if 13 > hour && 55 == minute
      return lookup('ES', 'IST', minute_words(60 - minute), 'VOR', 'MITTERNACHT') if 23 == hour && (55..59).cover?(minute)
      return lookup('ES', 'IST', minute_words(60 - minute), 'VOR', 'EINS') if hour.zero? && (55..59).cover?(minute)
      return lookup('ES', 'IST', minute_words(60 - minute), 'VOR', hour_words(hour + 1)) if 13 > hour && (55..59).cover?(minute)

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
        'VIERZIG',
        %w(EIN UND VIERZIG),
        %w(ZWEI UND VIERZIG),
        %w(DREI UND VIERZIG),
        %w(VIER UND VIERZIG),
        %w(FÜNF UND VIERZIG),
        %w(SECHS UND VIERZIG),
        %w(SIEBEN UND VIERZIG),
        %w(ACHT UND VIERZIG),
        %w(NEUN UND VIERZIG),
        'FÜNFZIG',
        %w(EIN UND FÜNFZIG),
        %w(ZWEI UND FÜNFZIG),
        %w(DREI UND FÜNFZIG),
        %w(VIER UND FÜNFZIG),
        %w(FÜNF UND FÜNFZIG),
        %w(SECHS UND FÜNFZIG),
        %w(SIEBEN UND FÜNFZIG),
        %w(ACHT UND FÜNFZIG),
        %w(NEUN UND FÜNFZIG),
      ][minute]
    end
  end
end
