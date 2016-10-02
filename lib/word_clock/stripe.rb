require 'faderuby'
require 'logger'

#
# Idea: Treat the whole thing as one logical stripe of LEDs and let a physical
# layer underneath figure out how to map a logical pixel to a physical position
#
module WordClock
  class Stripe
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

      lookup('ES', 'IST', hour_words(hour), 'UHR', minute_words(minute))
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
        ['DREI', 'ZEHN'],
        ['VIER', 'ZEHN'],
        ['FÜNF', 'ZEHN'],
        ['SECHS', 'ZEHN'],
        ['SIEBEN', 'ZEHN'],
        ['ACHT', 'ZEHN'],
        ['NEUN', 'ZEHN'],
        'ZWANZIG',
        ['EIN', 'UND', 'ZWANZIG'],
        ['ZWEI', 'UND', 'ZWANZIG'],
        ['DREI', 'UND', 'ZWANZIG'],
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
        ['DREI', 'ZEHN'],
        ['VIER', 'ZEHN'],
        ['FÜNF', 'ZEHN'],
        ['SECHS', 'ZEHN'],
        ['SIEBEN', 'ZEHN'],
        ['ACHT', 'ZEHN'],
        ['NEUN', 'ZEHN'],
        'ZWANZIG',
        ['EIN', 'UND', 'ZWANZIG'],
        ['ZWEI', 'UND', 'ZWANZIG'],
        ['DREI', 'UND', 'ZWANZIG'],
      ][minute]
    end
  end
end
