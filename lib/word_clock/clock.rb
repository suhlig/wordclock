require 'faderuby'
require 'csv'

module WordClock
  SIMULATOR = [
      'ESAISTOVIERTELEINS',
      'DREINERSECHSIEBENE',
      'ELFÜNFNEUNVIERACHT',
      'NULLZWEINZWÖLFZEHN',
      'UNDOZWANZIGVIERZIG',
      'DREISSIGFÜNFZIGUHR',
      'MINUTENIVORUNDNACH',
      'EINDREIVIERTELHALB',
      'SIEBENEUNULLZWEINE',
      'FÜNFSECHSNACHTVIER',
      'DREINSUNDAELFEZEHN',
      'ZWANZIGGRADREISSIG',
      'VIERZIGZWÖLFÜNFZIG',
      'MINUTENUHREFRÜHVOR',
      'ABENDSMITTERNACHTS',
      'MORGENSWARMMITTAGS',
  ]

  class Clock
    def initialize
      @client = FadeRuby::Client.new
      @matrix = FadeRuby::Matrix.new(16, 18)
      @table = CSV.read(
        'doc/wc24h1816_V3.csv', {
          col_sep: ';',
          headers: true,
          header_converters: [:downcase, :symbol],
          converters: [:numeric, ],
        }
      )

      reset
    end

    def show(time = Time.now)
      hours = []

      HOURS[time.hour].each do |part|
        row = table[WORD_POS.index(part)]

        (0..row[:length] - 1).each do |i|
          #matrix[row[:row], row[:column] + i] = FadeRuby::Pixel.new(255, 0, 0)
        end

        hours << SIMULATOR[row[:row]][row[:column]..(row[:column] + row[:length] - 1)]
      end

      minutes = []
      swap = false

      MINUTES[time.min].each do |part|
        if part.respond_to?(:to_sym)
          row = table[WORD_POS.index(part)]

          (0..row[:length] - 1).each do |i|
            #matrix[row[:row], row[:column] + i] = FadeRuby::Pixel.new(255, 0, 0)
          end

          minutes << SIMULATOR[row[:row]][row[:column]..(row[:column] + row[:length] - 1)]
        else
          swap = true if 1 == part
        end
      end

      if swap
        puts "y #{time}: #{minutes.join(' ')} #{hours.join(' ')}"
      else
        puts "x #{time}: #{minutes.join(' ')} #{hours.join(' ')}"
      end

      client.write(matrix)
    end

    def reset
      matrix.set_all(r: 0, g: 0, b: 0)
    end

    private

    attr_reader :client, :matrix, :table

    # from http://www.mikrocontroller.net/svnbrowser/wordclock24h/src/display/tables.c?revision=46&view=markup

    HOURS = [
      [:WP_NULL_2, :WP_UHR_2],                           #  0. Stunde in Mode HM_4
      [:WP_EIN_4, :WP_UHR_2],                            #  1. Stunde in Mode HM_4
      [:WP_ZWEI_2, :WP_UHR_2],                           #  2. Stunde in Mode HM_4
      [:WP_DREI_2, :WP_UHR_2],                           #  3. Stunde in Mode HM_4
      [:WP_VIER_2, :WP_UHR_2],                           #  4. Stunde in Mode HM_4
      [:WP_FUENF_2, :WP_UHR_2],                          #  5. Stunde in Mode HM_4
      [:WP_SECHS_2, :WP_UHR_2],                          #  6. Stunde in Mode HM_4
      [:WP_SIEBEN_2, :WP_UHR_2],                         #  7. Stunde in Mode HM_4
      [:WP_ACHT_2, :WP_UHR_2],                           #  8. Stunde in Mode HM_4
      [:WP_NEUN_2, :WP_UHR_2],                           #  9. Stunde in Mode HM_4
      [:WP_ZEHN_2, :WP_UHR_2],                           # 10. Stunde in Mode HM_4
      [:WP_ELF_2, :WP_UHR_2],                            # 11. Stunde in Mode HM_4
      [:WP_ZWOELF_2, :WP_UHR_2],                         # 12. Stunde in Mode HM_4
      [:WP_DREI_2, :WP_ZEHN_2, :WP_UHR_2],               # 13. Stunde in Mode HM_4
      [:WP_VIER_2, :WP_ZEHN_2, :WP_UHR_2],               # 14. Stunde in Mode HM_4
      [:WP_FUENF_2, :WP_ZEHN_2, :WP_UHR_2],              # 15. Stunde in Mode HM_4
      [:WP_SECH_2, :WP_ZEHN_2, :WP_UHR_2],               # 16. Stunde in Mode HM_4
      [:WP_SIEB_2, :WP_ZEHN_2, :WP_UHR_2],               # 17. Stunde in Mode HM_4
      [:WP_ACHT_2, :WP_ZEHN_2, :WP_UHR_2],               # 18. Stunde in Mode HM_4
      [:WP_NEUN_2, :WP_ZEHN_2, :WP_UHR_2],               # 19. Stunde in Mode HM_4
      [:WP_ZWANZIG_2, :WP_UHR_2],                        # 20. Stunde in Mode HM_4
      [:WP_EIN_4, :WP_UND_3, :WP_ZWANZIG_2, :WP_UHR_2],  # 21. Stunde in Mode HM_4
      [:WP_ZWEI_2, :WP_UND_3, :WP_ZWANZIG_2, :WP_UHR_2], # 22. Stunde in Mode HM_4
      [:WP_DREI_2, :WP_UND_3, :WP_ZWANZIG_2, :WP_UHR_2], # 23. Stunde in Mode HM_4
      [:WP_VIER_2, :WP_UND_3, :WP_ZWANZIG_2, :WP_UHR_2], # 24. Stunde in Mode HM_4
    ]

    MINUTES = [
      [0, :WP_UHR_2],                                                   # 0. Minute in Mode MM_3
      [0, :WP_EINE_1, :WP_MINUTE_1, :WP_NACH_1],                        # 1. Minute in Mode MM_3
      [0, :WP_ZWEI_1, :WP_MINUTEN_1, :WP_NACH_1],                       # 2. Minute in Mode MM_3
      [0, :WP_DREI_1, :WP_MINUTEN_1, :WP_NACH_1],                       # 3. Minute in Mode MM_3
      [0, :WP_VIER_1, :WP_MINUTEN_1, :WP_NACH_1],                       # 4. Minute in Mode MM_3
      [0, :WP_FUENF_1, :WP_MINUTEN_1, :WP_NACH_1],                      # 5. Minute in Mode MM_3
      [0, :WP_SECHS_1, :WP_MINUTEN_1, :WP_NACH_1],                      # 6. Minute in Mode MM_3
      [0, :WP_SIEBEN_1, :WP_MINUTEN_1, :WP_NACH_1],                     # 7. Minute in Mode MM_3
      [0, :WP_ACHT_1, :WP_MINUTEN_1, :WP_NACH_1],                       # 8. Minute in Mode MM_3
      [0, :WP_NEUN_1, :WP_MINUTEN_1, :WP_NACH_1],                       # 9. Minute in Mode MM_3
      [0, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1],                       # 10. Minute in Mode MM_3
      [0, :WP_ELF_1, :WP_MINUTEN_1, :WP_NACH_1],                        # 11. Minute in Mode MM_3
      [0, :WP_ZWOELF_1, :WP_MINUTEN_1, :WP_NACH_1],                     # 12. Minute in Mode MM_3
      [0, :WP_DREI_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1],           # 13. Minute in Mode MM_3
      [0, :WP_VIER_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1],           # 14. Minute in Mode MM_3
      [1, :WP_VIERTEL_1],                                               # 15. Minute in Mode MM_3
      [0, :WP_SECH_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1],           # 16. Minute in Mode MM_3
      [0, :WP_SIEB_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1],           # 17. Minute in Mode MM_3
      [0, :WP_ACHT_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1],           # 18. Minute in Mode MM_3
      [0, :WP_NEUN_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1],           # 19. Minute in Mode MM_3
      [1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],              # 20. Minute in Mode MM_3
      [1, :WP_NEUN_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],              # 21. Minute in Mode MM_3
      [1, :WP_ACHT_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],              # 22. Minute in Mode MM_3
      [1, :WP_SIEBEN_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],            # 23. Minute in Mode MM_3
      [1, :WP_SECHS_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],             # 24. Minute in Mode MM_3
      [1, :WP_FUENF_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],             # 25. Minute in Mode MM_3
      [1, :WP_VIER_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],              # 26. Minute in Mode MM_3
      [1, :WP_DREI_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],              # 27. Minute in Mode MM_3
      [1, :WP_ZWEI_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],              # 28. Minute in Mode MM_3
      [1, :WP_EINE_1, :WP_MINUTEN_1, :WP_VOR_1, :WP_HALB],              # 29. Minute in Mode MM_3
      [1, :WP_HALB],                                                    # 30. Minute in Mode MM_3
      [1, :WP_EINE_1, :WP_MINUTE_1, :WP_NACH_1, :WP_HALB],              # 31. Minute in Mode MM_3
      [1, :WP_ZWEI_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],             # 32. Minute in Mode MM_3
      [1, :WP_DREI_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],             # 33. Minute in Mode MM_3
      [1, :WP_VIER_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],             # 34. Minute in Mode MM_3
      [1, :WP_FUENF_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],            # 35. Minute in Mode MM_3
      [1, :WP_SECHS_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],            # 36. Minute in Mode MM_3
      [1, :WP_SIEBEN_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],           # 37. Minute in Mode MM_3
      [1, :WP_ACHT_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],             # 38. Minute in Mode MM_3
      [1, :WP_NEUN_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],             # 39. Minute in Mode MM_3
      [1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],             # 40. Minute in Mode MM_3
      [1, :WP_ELF_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],              # 41. Minute in Mode MM_3
      [1, :WP_ZWOELF_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB],           # 42. Minute in Mode MM_3
      [1, :WP_DREI_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB], # 43. Minute in Mode MM_3
      [1, :WP_VIER_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_NACH_1, :WP_HALB], # 44. Minute in Mode MM_3
      [1, :WP_DREIVIERTEL],                                             # 45. Minute in Mode MM_3
      [1, :WP_VIER_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_VOR_1],            # 46. Minute in Mode MM_3
      [1, :WP_DREI_1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_VOR_1],            # 47. Minute in Mode MM_3
      [1, :WP_ZWOELF_1, :WP_MINUTEN_1, :WP_VOR_1],                      # 48. Minute in Mode MM_3
      [1, :WP_ELF_1, :WP_MINUTEN_1, :WP_VOR_1],                         # 49. Minute in Mode MM_3
      [1, :WP_ZEHN_1, :WP_MINUTEN_1, :WP_VOR_1],                        # 50. Minute in Mode MM_3
      [1, :WP_NEUN_1, :WP_MINUTEN_1, :WP_VOR_1],                        # 51. Minute in Mode MM_3
      [1, :WP_ACHT_1, :WP_MINUTEN_1, :WP_VOR_1],                        # 52. Minute in Mode MM_3
      [1, :WP_SIEBEN_1, :WP_MINUTEN_1, :WP_VOR_1],                      # 53. Minute in Mode MM_3
      [1, :WP_SECHS_1, :WP_MINUTEN_1, :WP_VOR_1],                       # 54. Minute in Mode MM_3
      [1, :WP_FUENF_1, :WP_MINUTEN_1, :WP_VOR_1],                       # 55. Minute in Mode MM_3
      [1, :WP_VIER_1, :WP_MINUTEN_1, :WP_VOR_1],                        # 56. Minute in Mode MM_3
      [1, :WP_DREI_1, :WP_MINUTEN_1, :WP_VOR_1],                        # 57. Minute in Mode MM_3
      [1, :WP_ZWEI_1, :WP_MINUTEN_1, :WP_VOR_1],                        # 58. Minute in Mode MM_3
      [1, :WP_EINE_1, :WP_MINUTE_1, :WP_VOR_1]                          # 59. Minute in Mode MM_3
    ]

    # from http://www.mikrocontroller.net/svnbrowser/wordclock24h/src/display/tables.h?revision=46&view=markup
    WORD_POS = [
      :WP_END_OF_WORDS, # 0 = "0_END_OF_WORDS" = ""
      :WP_ES,           # 1 = "1_ES" = "ES"
      :WP_IST,          # 2 = "2_IST" = "IST"
      :WP_VIERTEL_1,    # 3 = "3_VIERTEL" = "VIERTEL"
      :WP_EIN_1,        # 4 = "4_EIN" = "EIN"
      :WP_EINS_1,       # 5 = "5_EINS" = "EINS"
      :WP_IN,           # 6 = "6_IN" = "IN"
      :WP_DREI_1,       # 7 = "7_DREI" = "DREI"
      :WP_EIN_2,        # 8 = "8_EIN" = "EIN"
      :WP_EINE_1,       # 9 = "9_EINE" = "EINE"
      :WP_EINER,        # 10 = "10_EINER" = "EINER"
      :WP_SECH_1,       # 11 = "11_SECH" = "SECH"
      :WP_SECHS_1,      # 12 = "12_SECHS" = "SECHS"
      :WP_SIEB_1,       # 13 = "13_SIEB" = "SIEB"
      :WP_SIEBEN_1,     # 14 = "14_SIEBEN" = "SIEBEN"
      :WP_ELF_1,        # 15 = "15_ELF" = "ELF"
      :WP_FUENF_1,      # 16 = "16_FUENF" = "F�NF"
      :WP_NEUN_1,       # 17 = "17_NEUN" = "NEUN"
      :WP_VIER_1,       # 18 = "18_VIER" = "VIER"
      :WP_ACHT_1,       # 19 = "19_ACHT" = "ACHT"
      :WP_NULL_1,       # 20 = "20_NULL" = "NULL"
      :WP_ZWEI_1,       # 21 = "21_ZWEI" = "ZWEI"
      :WP_ZWOELF_1,     # 22 = "22_ZWOELF" = "ZW�LF"
      :WP_ZEHN_1,       # 23 = "23_ZEHN" = "ZEHN"
      :WP_UND_1,        # 24 = "24_UND" = "UND"
      :WP_ZWANZIG_1,    # 25 = "25_ZWANZIG" = "ZWANZIG"
      :WP_VIERZIG_1,    # 26 = "26_VIERZIG" = "VIERZIG"
      :WP_DREISSIG_1,   # 27 = "27_DREISSIG" = "DREISSIG"
      :WP_FUENFZIG_1,   # 28 = "28_FUENFZIG" = "F�NFZIG"
      :WP_UHR_1,        # 29 = "29_UHR" = "UHR"
      :WP_MINUTE_1,     # 30 = "30_MINUTE" = "MINUTE"
      :WP_MINUTEN_1,    # 31 = "31_MINUTEN" = "MINUTEN"
      :WP_VOR_1,        # 32 = "32_VOR" = "VOR"
      :WP_UND_2,        # 33 = "33_UND" = "UND"
      :WP_NACH_1,       # 34 = "34_NACH" = "NACH"
      :WP_EIN_3,        # 35 = "35_EIN" = "EIN"
      :WP_DREIVIERTEL,  # 36 = "36_DREIVIERTEL" = "DREIVIERTEL"
      :WP_VIERTEL_2,    # 37 = "37_VIERTEL" = "VIERTEL"
      :WP_HALB,         # 38 = "38_HALB" = "HALB"
      :WP_SIEB_2,       # 39 = "39_SIEB" = "SIEB"
      :WP_SIEBEN_2,     # 40 = "40_SIEBEN" = "SIEBEN"
      :WP_NEUN_2,       # 41 = "41_NEUN" = "NEUN"
      :WP_NULL_2,       # 42 = "42_NULL" = "NULL"
      :WP_ZWEI_2,       # 43 = "43_ZWEI" = "ZWEI"
      :WP_EIN_4,        # 44 = "44_EIN" = "EIN"
      :WP_EINE_2,       # 45 = "45_EINE" = "EINE"
      :WP_FUENF_2,      # 46 = "46_FUENF" = "F�NF"
      :WP_SECH_2,       # 47 = "47_SECH" = "SECH"
      :WP_SECHS_2,      # 48 = "48_SECHS" = "SECHS"
      :WP_ACHT_2,       # 49 = "49_ACHT" = "ACHT"
      :WP_VIER_2,       # 50 = "50_VIER" = "VIER"
      :WP_DREI_2,       # 51 = "51_DREI" = "DREI"
      :WP_EIN_5,        # 52 = "52_EIN" = "EIN"
      :WP_EINS_2,       # 53 = "53_EINS" = "EINS"
      :WP_UND_3,        # 54 = "54_UND" = "UND"
      :WP_ELF_2,        # 55 = "55_ELF" = "ELF"
      :WP_ZEHN_2,       # 56 = "56_ZEHN" = "ZEHN"
      :WP_ZWANZIG_2,    # 57 = "57_ZWANZIG" = "ZWANZIG"
      :WP_GRAD,         # 58 = "58_GRAD" = "GRAD"
      :WP_DREISSIG_2,   # 59 = "59_DREISSIG" = "DREISSIG"
      :WP_VIERZIG_2,    # 60 = "60_VIERZIG" = "VIERZIG"
      :WP_ZWOELF_2,     # 61 = "61_ZW�LF" = "ZW�LF"
      :WP_FUENFZIG_2,   # 62 = "62_FUENFZIG" = "F�NFZIG"
      :WP_MINUTE_2,     # 63 = "63_MINUTE" = "MINUTE"
      :WP_MINUTEN_2,    # 64 = "64_MINUTEN" = "MINUTEN"
      :WP_UHR_2,        # 65 = "65_UHR" = "UHR"
      :WP_FRUEH,        # 66 = "66_FRUEH" = "FR�H"
      :WP_VOR_2,        # 67 = "67_VOR" = "VOR"
      :WP_ABENDS,       # 68 = "68_ABENDS" = "ABENDS"
      :WP_MITTERNACHT,  # 69 = "69_MITTERNACHT" = "MITTERNACHT"
      :WP_NACH_2,       # 70 = "70_NACH" = "NACH"
      :WP_NACHTS,       # 71 = "71_NACHTS" = "NACHTS"
      :WP_MORGENS,      # 72 = "72_MORGENS" = "MORGENS"
      :WP_WARM,         # 73 = "73_WARM" = "WARM"
      :WP_MITTAGS,      # 74 = "74_MITTAGS" = "MITTAGS"
      :WP_COUNT,        # number of words
    ]
  end
end
