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
  # 2:00..02:04

  describe 'es ist fünf nach zwei' do
    it_behaves_like_a_word_clock(
      2,
      5,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 122, 123, 124, 125, 182, 183, 184, 185]
    )
  end

  # 2:06..02:09

  describe 'es ist zehn nach zwei' do
    it_behaves_like_a_word_clock(
      2,
      10,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 122, 123, 124, 125, 182, 183, 184, 185]
    )
  end

  # 2:11..02:59
end
