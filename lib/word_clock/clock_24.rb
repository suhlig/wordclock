# frozen_string_literal: true

module WordClock
  class Clock24
    class << self
      #
      # For the given pixel indices, return the words (without spaces) that are lit
      #
      def words(pixels)
        Array(pixels).map { |i| chars[i] }.join
      end

      def chars
        STRIPE.dup.chars
      end
    end

    def initialize(time=Time.now)
      @time = time
    end

    attr_accessor :time

    #
    # For the current hour and minute, return the indices of all pixels to be lit
    # in the stripe of pixels.
    #
    # rubocop:disable Metrics/CyclomaticComplexity
    def pixels
      if hour.zero?
        return lookup('ES', 'IST', 'MITTERNACHT')                               if minute.zero?
        return lookup('ES', 'IST', 'EINS', 'NACH', 'MITTERNACHT')               if minute == 1
        return lookup('ES', 'IST', minute_words(minute), 'NACH', 'MITTERNACHT') if (2..5).cover?(minute)
        return lookup('ES', 'IST', minute_words(minute), 'NACH', 'MITTERNACHT') if minute == 10
        return lookup('ES', 'IST', 'VIERTEL', 'EINS')                           if minute == 15
        return lookup('ES', 'IST', 'ZEHN', 'VOR', 'HALB', 'EINS')               if minute == 20
        return lookup('ES', 'IST', 'FÜNF', 'VOR', 'HALB', 'EINS')               if minute == 25
        return lookup('ES', 'IST', 'HALB', 'EINS')                              if minute == 30
        return lookup('ES', 'IST', 'FÜNF', 'NACH', 'HALB', 'EINS')              if minute == 35
        return lookup('ES', 'IST', 'ZEHN', 'NACH', 'HALB', 'EINS')              if minute == 40
        return lookup('ES', 'IST', 'DREI', 'VIERTEL', 'EINS')                   if minute == 45
        return lookup('ES', 'IST', 'ZEHN', 'VOR', 'EINS')                       if minute == 50
        return lookup('ES', 'IST', 'FÜNF', 'VOR', 'EINS')                       if minute == 55
        return lookup('ES', 'IST', minute_words(60 - minute), 'VOR', 'EINS')    if (55..59).cover?(minute)
      end

      if hour == 1
        return lookup('ES', 'IST', 'FÜNF', 'NACH', 'EINS') if minute == 5
        return lookup('ES', 'IST', 'ZEHN', 'NACH', 'EINS') if minute == 10
      end

      if hour < 12
        return lookup('ES', 'IST', 'FÜNF', 'NACH', hour_words(hour))             if minute == 5
        return lookup('ES', 'IST', 'ZEHN', 'NACH', hour_words(hour))             if minute == 10
        return lookup('ES', 'IST', 'VIERTEL', hour_words(hour + 1))              if minute == 15
        return lookup('ES', 'IST', 'ZEHN', 'VOR', 'HALB', hour_words(hour + 1))  if minute == 20
        return lookup('ES', 'IST', 'FÜNF', 'VOR', 'HALB', hour_words(hour + 1))  if minute == 25
        return lookup('ES', 'IST', 'HALB', hour_words(hour + 1))                 if minute == 30
        return lookup('ES', 'IST', 'FÜNF', 'NACH', 'HALB', hour_words(hour + 1)) if minute == 35
        return lookup('ES', 'IST', 'ZEHN', 'NACH', 'HALB', hour_words(hour + 1)) if minute == 40
        return lookup('ES', 'IST', 'DREI', 'VIERTEL', hour_words(hour + 1))      if minute == 45
        return lookup('ES', 'IST', 'ZEHN', 'VOR', hour_words(hour + 1))          if minute == 50
        return lookup('ES', 'IST', 'FÜNF', 'VOR', hour_words(hour + 1))          if minute == 55
        return lookup('ES', 'IST', minute_words(60 - minute), 'VOR', hour_words(hour + 1)) if (55..59).cover?(minute)
      end

      if hour == 23
        return lookup('ES', 'IST', minute_words(60 - minute), 'VOR', 'MITTERNACHT') if (55..59).cover?(minute)
      end

      lookup('ES', 'IST', hour_words(hour), 'UHR', minute_words(minute))
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    private

    # All words on the [WC24h](https://www.mikrocontroller.net/articles/WordClock_mit_WS2812#WC24h_Sammelbestellung_Frontplatten)
    STRIPE = 'ESAISTOVIERTELEINS' \
             'DREINERSECHSIEBENE' \
             'ELFÜNFNEUNVIERACHT' \
             'NULLZWEINZWÖLFZEHN' \
             'UNDOZWANZIGVIERZIG' \
             'DREISSIGFÜNFZIGUHR' \
             'MINUTENIVORUNDNACH' \
             'EINDREIVIERTELHALB' \
             'SIEBENEUNULLZWEINE' \
             'FÜNFSECHSNACHTVIER' \
             'DREINSUNDAELFEZEHN' \
             'ZWANZIGGRADREISSIG' \
             'VIERZIGZWÖLFÜNFZIG' \
             'MINUTENUHREFRÜHVOR' \
             'ABENDSMITTERNACHTS' \
             'MORGENSWARMMITTAGS' \

    attr_reader :hour, :minute

    def lookup(*words)
      index = 0

      words.compact.flatten.map do |word|
        index = STRIPE.index(word, index)
        last = index + word.length
        (index..(last - 1)).to_a.tap do
          index = last

          # Search after the next char except we are at the end of the current line
          # so that there is always space between two words
          index += 1 unless (index % 18).zero?
        end
      end.compact.flatten
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
        %w[DREI ZEHN],
        %w[VIER ZEHN],
        %w[FÜNF ZEHN],
        %w[SECH ZEHN],
        %w[SIEB ZEHN],
        %w[ACHT ZEHN],
        %w[NEUN ZEHN],
        'ZWANZIG',
        %w[EIN UND ZWANZIG],
        %w[ZWEI UND ZWANZIG],
        %w[DREI UND ZWANZIG]
      ][hour]
    end

    # rubocop:disable Metrics/MethodLength
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
        %w[DREI ZEHN],
        %w[VIER ZEHN],
        %w[FÜNF ZEHN],
        %w[SECH ZEHN],
        %w[SIEB ZEHN],
        %w[ACHT ZEHN],
        %w[NEUN ZEHN],
        'ZWANZIG',
        %w[EIN UND ZWANZIG],
        %w[ZWEI UND ZWANZIG],
        %w[DREI UND ZWANZIG],
        %w[VIER UND ZWANZIG],
        %w[FÜNF UND ZWANZIG],
        %w[SECHS UND ZWANZIG],
        %w[SIEBEN UND ZWANZIG],
        %w[ACHT UND ZWANZIG],
        %w[NEUN UND ZWANZIG],
        'DREISSIG',
        %w[EIN UND DREISSIG],
        %w[ZWEI UND DREISSIG],
        %w[DREI UND DREISSIG],
        %w[VIER UND DREISSIG],
        %w[FÜNF UND DREISSIG],
        %w[SECHS UND DREISSIG],
        %w[SIEBEN UND DREISSIG],
        %w[ACHT UND DREISSIG],
        %w[NEUN UND DREISSIG],
        'VIERZIG',
        %w[EIN UND VIERZIG],
        %w[ZWEI UND VIERZIG],
        %w[DREI UND VIERZIG],
        %w[VIER UND VIERZIG],
        %w[FÜNF UND VIERZIG],
        %w[SECHS UND VIERZIG],
        %w[SIEBEN UND VIERZIG],
        %w[ACHT UND VIERZIG],
        %w[NEUN UND VIERZIG],
        'FÜNFZIG',
        %w[EIN UND FÜNFZIG],
        %w[ZWEI UND FÜNFZIG],
        %w[DREI UND FÜNFZIG],
        %w[VIER UND FÜNFZIG],
        %w[FÜNF UND FÜNFZIG],
        %w[SECHS UND FÜNFZIG],
        %w[SIEBEN UND FÜNFZIG],
        %w[ACHT UND FÜNFZIG],
        %w[NEUN UND FÜNFZIG],
      ][minute]
    end

    def hour
      time.hour
    end

    def minute
      time.min
    end
  end
end
