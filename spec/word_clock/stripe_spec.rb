# frozen_string_literal: true
require 'spec_helper'

require 'word_clock/stripe'

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
      expect(pixels.size).to eq(16) # length of spec name without spaces
    end

    it 'has the right pixels lit' do
      expect(pixels).to be([0, 1, 3, 4, 5, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268])
    end
  end

  context 'es ist es sechs uhr vierzehn' do
    let(:hour) { 6 }
    let(:minute) { 14 }

    it 'has the right amount of pixels lit' do
      expect(pixels.size).to eq(16) # length of spec name without spaces
    end

    it 'has the right pixels lit' do
      expect(pixels).to be([0, 1, 3, 4, 5, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268])
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
