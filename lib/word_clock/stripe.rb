
require 'faderuby'

#
# Idea: Treat the whole thing as one logical stripe of LEDs and let a physical
# layer underneath figure out how to map a logical pixel to a physical position
#
module WordClock
  class Stripe
    STRIPE = 'ESAISTOVIERTELEINSDREINERSECHSIEBENEELFÜNFNEUNVIERACHTNULLZWEINZWÖLFZEHNUNDOZWANZIGVIERZIGDREISSIGFÜNFZIGUHRMINUTENIVORUNDNACHEINDREIVIERTELHALBSIEBENEUNULLZWEINEFÜNFSECHSNACHTVIERDREINSUNDAELFEZEHNZWANZIGGRADREISSIGVIERZIGZWÖLFÜNFZIGMINUTENUHREFRÜHVORABENDSMITTERNACHTSMORGENSWARMMITTAGS'

    # Idea: find each word in STRIPE and get their positions. These are the bits
    # to be set.
    def pixels(hour, minute)
      ['ES', 'IST', hour_words(hour), minute_words(minute)].map do |words|
        result = Array(words).map do |word|
          first = STRIPE.index(word)
          last = first + word.length
          (first..last).to_a
        end

        warn "#{words}:  #{result}"
      end.flatten
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
      []
    end
  end
end
