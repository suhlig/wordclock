# frozen_string_literal: true
require 'spec_helper'
require 'word_clock/stripe'
require 'shared_examples_for_word_clock'

# Indexes (read from top to bottom, with MSB in the top row)
#                                                                                                     1         1         1         1         1         1         1         1         1         1         2         2         2         2         2         2         2         2         2
#           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8
# 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
# ESAISTOVIERTELEINSDREINERSECHSIEBENEELFÜNFNEUNVIERACHTNULLZWEINZWÖLFZEHNUNDOZWANZIGVIERZIGDREISSIGFÜNFZIGUHRMINUTENIVORUNDNACHEINDREIVIERTELHALBSIEBENEUNULLZWEINEFÜNFSECHSNACHTVIERDREINSUNDAELFEZEHNZWANZIGGRADREISSIGVIERZIGZWÖLFÜNFZIGMINUTENUHREFRÜHVORABENDSMITTERNACHTSMORGENSWARMMITTAGS
RSpec.describe WordClock::Stripe do
  describe 'es ist mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      0,
      phrase_length(description),
      [0, 1, 3, 4, 5, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist ist eine minute nach mitternacht' do
  end

  describe 'es ist sechs uhr vier zehn' do
    it_behaves_like_a_word_clock(
      6,
      14,
      phrase_length(description),
      [0, 1, 3, 4, 5, 25, 26, 27, 28, 29, 105, 106, 107, 133, 134, 135, 136, 194, 195, 196, 197]
    )
  end

  # 'es ist ist eine minute vor mitternacht'
end
