# frozen_string_literal: true
require 'spec_helper'

require 'word_clock/stripe'

# Indexes (read from top to bottom, with MSB in the top row)
#                                                                                                     1         1         1         1         1         1         1         1         1         1         2         2         2         2         2         2         2         2         2
#           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8
# 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
# ESAISTOVIERTELEINSDREINERSECHSIEBENEELFÜNFNEUNVIERACHTNULLZWEINZWÖLFZEHNUNDOZWANZIGVIERZIGDREISSIGFÜNFZIGUHRMINUTENIVORUNDNACHEINDREIVIERTELHALBSIEBENEUNULLZWEINEFÜNFSECHSNACHTVIERDREINSUNDAELFEZEHNZWANZIGGRADREISSIGVIERZIGZWÖLFÜNFZIGMINUTENUHREFRÜHVORABENDSMITTERNACHTSMORGENSWARMMITTAGS
describe WordClock::Stripe do
  let(:pixels) { subject.pixels(hour, minute) }

  context 'es ist mitternacht' do
    let(:hour) { 0 }
    let(:minute) { 0 }

    it 'has the right amount of pixels lit' do
      expect(pixels.size).to eq(16) # TODO This is the length of the spec name sans the spaces
    end

    it 'has the right pixels lit' do
      expect(pixels).to eq([0, 1, 3, 4, 5, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268])
    end
  end

  #                                                                                                     1         1         1         1         1         1         1         1         1         1         2         2         2         2         2         2         2         2         2
  #           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8
  # 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
  # ESAISTOVIERTELEINSDREINERSECHSIEBENEELFÜNFNEUNVIERACHTNULLZWEINZWÖLFZEHNUNDOZWANZIGVIERZIGDREISSIGFÜNFZIGUHRMINUTENIVORUNDNACHEINDREIVIERTELHALBSIEBENEUNULLZWEINEFÜNFSECHSNACHTVIERDREINSUNDAELFEZEHNZWANZIGGRADREISSIGVIERZIGZWÖLFÜNFZIGMINUTENUHREFRÜHVORABENDSMITTERNACHTSMORGENSWARMMITTAGS
  context 'es ist es sechs uhr vier zehn' do
    let(:hour) { 6 }
    let(:minute) { 14 }

    it 'has the right amount of pixels lit' do
      expect(pixels.size).to eq(21)
    end

    xit 'indices are only increasing' do
      # every pixel index must be larger than its predecessor
    end

    it 'has the right pixels lit' do
      expect(pixels).to eq([0, 1, 3, 4, 5, 25, 26, 27, 28, 29, 105, 106, 107, 133, 134, 135, 136, 194, 195, 196, 197])
    end
  end
end

__END__

# 00:00 => es ist mitternacht
# 00:01 => es ist es ist eine minute nach mitternacht
# ...
# 06:14 => es ist es sechs uhr vierzehn
# ...
# 23:59 => es ist es ist eine minute vor mitternacht
#   23° => es ist drei und zwanzig grad
