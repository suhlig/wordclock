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
    let(:expected_pixels){[0, 1, 3, 4, 5, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]}

    phrase_length = description.tr(' ', '').length

    it 'has the right amount of pixels lit' do
      expect(pixels.size).to eq(phrase_length)
    end

    it 'has indices that are only increasing' do
      pixels.each_cons(2) do |prev, this|
        expect(this).to be > prev
      end
    end

    it 'has the right pixels lit' do
      expect(pixels).to eq(expected_pixels)
    end
  end

  context 'es ist sechs uhr vier zehn' do
    let(:hour) { 6 }
    let(:minute) { 14 }
    let(:expected_pixels){[0, 1, 3, 4, 5, 25, 26, 27, 28, 29, 105, 106, 107, 133, 134, 135, 136, 194, 195, 196, 197]}

    phrase_length = description.tr(' ', '').length

    it 'has the right amount of pixels lit' do
      expect(pixels.size).to eq(phrase_length)
    end

    it 'has indices that are only increasing' do
      pixels.each_cons(2) do |prev, this|
        expect(this).to be > prev
      end
    end

    it 'has the right pixels lit' do
      expect(pixels).to eq(expected_pixels)
    end
  end

  context 'es ist ist eine minute nach mitternacht' do
    let(:hour) { 0 }
    let(:minute) { 1 }
  end

  context 'es ist ist eine minute vor mitternacht' do
    let(:hour) { 23 }
    let(:minute) { 59 }
  end
end
